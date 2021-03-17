package com.node.crm.workbench.service.impl;

import com.node.crm.settings.dao.UserDao;
import com.node.crm.settings.domain.User;
import com.node.crm.utils.DateTimeUtil;
import com.node.crm.utils.UUIDUtil;
import com.node.crm.vo.PaginationVO;
import com.node.crm.workbench.dao.*;
import com.node.crm.workbench.domain.*;
import com.node.crm.workbench.service.ClueService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ClueServiceImpl implements ClueService {

    // 用户相关表
    @Resource
    private UserDao userDao;

    // 线索相关表
    @Resource
    private ClueDao clueDao;
    @Resource
    private ClueRemarkDao clueRemarkDao;
    @Resource
    private ClueActivityRelationDao clueActivityRelationDao;

    // 客户相关表
    @Resource
    private CustomerDao customerDao;
    @Resource
    private CustomerRemarkDao customerRemarkDao;

    // 联系人相关表
    @Resource
    private ContactsDao contactsDao;
    @Resource
    private ContactsRemarkDao contactsRemarkDao;
    @Resource
    private ContactsActivityRelationDao contactsActivityRelationDao;

    // 交易相关表
    @Resource
    private TranDao tranDao;
    @Resource
    private TranHistoryDao tranHistoryDao;

    @Override
    public PaginationVO<Clue> pageList(Map<String, Object> map) {

        //取得total
        int total = clueDao.getTotalByCondition(map);

        //取得dataList
        List<Clue> dataList = clueDao.getActivityListByCondition(map);

        //创建一个vo对象，将total和dataList封装到vo中
        PaginationVO<Clue> vo = new PaginationVO<>();
        vo.setTotal(total);
        vo.setDataList(dataList);

        //将vo返回
        return vo;
    }

    @Override
    public boolean save(Clue c) {

        boolean flag = true;

        int count = clueDao.save(c);

        if (count != 1) {

            flag = false;

        }

        return flag;

    }

    @Override
    public boolean delete(String[] ids) {

        boolean flag = true;

        for (String id : ids) {

            int count = clueDao.delete(id);

            if (count != 1) {

                flag = false;

            }

        }

        return flag;
    }

    @Override
    public Clue detail(String id) {

        Clue c = clueDao.detail(id);

        return c;

    }

    @Override
    public boolean saveRemark(ClueRemark cr) {

        boolean flag = true;

        int count = clueRemarkDao.saveRemark(cr);

        if (count != 1) {

            flag = false;

        }

        return flag;
    }

    @Override
    public Clue getClueById(String clueId) {

        Clue clue = clueDao.getClueById(clueId);

        return clue;
    }

    @Override
    public List<ClueRemark> getRemarkListByCid(String clueId) {

        List<ClueRemark> list = clueRemarkDao.getRemarkListByCid(clueId);

        return list;
    }

    @Override
    public Map<String, Object> getUserListAndClue(String id) {

        Map<String, Object> map = new HashMap<>();
        List<User> uList = userDao.getUserList();
        Clue c = clueDao.getClueById(id);
        map.put("uList", uList);
        map.put("c", c);
        return map;
    }

    @Override
    public boolean update(Clue clue) {

        boolean flag = true;
        int count = clueDao.update(clue);
        if (count != 1) {

            flag = false;

        }
        return flag;
    }

    @Override
    public List<Activity> getActivityListByNameAndNotByClueId(String aname, String clueId) {

        Map<String, Object> map = new HashMap<>();
        map.put("aname", aname);
        map.put("clueId", clueId);
        List<Activity> list = clueDao.getActivityListByNameAndNotByClueId(map);
        return list;
    }

    @Override
    public boolean bund(String cid, String[] aid) {

        boolean flag = true;

        for (String id : aid) {

            ClueActivityRelation car = new ClueActivityRelation();
            car.setId(UUIDUtil.getUUID());
            car.setClueId(cid);
            car.setActivityId(id);
            int count = clueDao.bund(car);
            if (count != 1) {

                flag = false;

            }

        }

        return flag;
    }

    @Override
    public List<Activity> getActivityByCid(String cid) {

        List<Activity> list = clueDao.getActivityByCid(cid);

        return list;
    }

    @Override
    public boolean unbund(ClueActivityRelation car) {
        boolean flag = true;

        int count = clueDao.unbund(car);
        if (count != 1) {

            flag = false;

        }

        return flag;
    }

    @Override
    public List<Activity> getActivityListByName(String aname) {

        List<Activity> list = clueDao.getActivityListByName(aname);
        return list;

    }

    @Override
    public boolean convert(String clueId, Tran t, String createBy) {

        boolean flag = true;
        String createTime = DateTimeUtil.getSysTime();

        // (1)根据线索id获取线索对象（线索对象当中封装了线索的信息）
        Clue c = clueDao.getById(clueId);

        // (2)通过线索对象提取客户信息，当该客户不存在的时候，新建客户（根据公司的名称精准匹配，判断该客户是否存在）
        String company = c.getCompany();
        Customer cus = customerDao.getCustomerByName(company);
        // 如果cus为null，说明以前没有这个客户，需要新建一个
        if (cus == null) {

            cus = new Customer();
            cus.setId(UUIDUtil.getUUID());
            cus.setCreateTime(createTime);
            cus.setCreateBy(createBy);
            cus.setAddress(c.getAddress());
            cus.setWebsite(c.getWebsite());
            cus.setOwner(c.getOwner());
            cus.setPhone(c.getPhone());
            cus.setNextContactTime(c.getNextContactTime());
            cus.setName(c.getCompany());
            cus.setDescription(c.getDescription());
            cus.setContactSummary(c.getContactSummary());

            // 添加客户
            int count1 = customerDao.save(cus);
            if (count1 != 1) {

                flag = false;

            }

        }

        // -------------------------------------------------------------------------
        // 经过第二步处理之后，客户的信息我们已经拥有了，将来在处理其它表的时候，如果要使用到客户的id
        // 直接使用cus.getId()
        // -------------------------------------------------------------------------

        // (3)通过线索对象提取联系人信息，保存联系人
        Contacts con = new Contacts();
        con.setId(UUIDUtil.getUUID());
        con.setSource(c.getSource());
        con.setOwner(c.getOwner());
        con.setNextContactTime(c.getNextContactTime());
        con.setMphone(c.getMphone());
        con.setJob(c.getJob());
        con.setFullname(c.getFullname());
        con.setEmail(c.getEmail());
        con.setDescription(c.getDescription());
        con.setCustomerId(cus.getId());
        con.setCreateTime(createTime);
        con.setCreateBy(createBy);
        con.setContactSummary(c.getContactSummary());
        con.setAppellation(c.getAppellation());
        con.setAddress(c.getAddress());

        // 添加联系人
        int count2 = contactsDao.save(con);

        if (count2 != 1) {

            flag = false;

        }
        // ----------------------------------------------------------------------------
        // 经过第三步处理之后，联系人的信息我们已经拥有了，将来在处理其它表的时候，如果要使用到联系人的id
        // 直接使用con.getId()
        // ----------------------------------------------------------------------------

        // (4)线索备注转换到客户备注以及联系人备注
        // 查询出与该线索关联的备注信息列表
        List<ClueRemark> clueRemarkList = clueRemarkDao.getListByClueId(clueId);
        // 取出每一条线索的备注
        for (ClueRemark clueRemark : clueRemarkList) {

            // 取出备注信息（主要转换到客户备注和联系人备注的就是这个备注信息）
            String noteContent = clueRemark.getNoteContent();

            // 创建客户备注对象，添加客户备注
            CustomerRemark customerRemark = new CustomerRemark();
            customerRemark.setNoteContent(noteContent);
            customerRemark.setId(UUIDUtil.getUUID());
            customerRemark.setCustomerId(cus.getId());
            customerRemark.setCreateTime(createTime);
            customerRemark.setCreateBy(createBy);
            customerRemark.setEditFlag("0");

            int count3 = customerRemarkDao.save(customerRemark);

            if (count3 != 1) {

                flag = false;

            }

            // 创建联系人备注对象，添加联系人备注
            ContactsRemark contactsRemark = new ContactsRemark();
            contactsRemark.setNoteContent(noteContent);
            contactsRemark.setId(UUIDUtil.getUUID());
            contactsRemark.setContactsId(con.getId());
            contactsRemark.setCreateTime(createTime);
            contactsRemark.setCreateBy(createBy);
            contactsRemark.setEditFlag("0");

            int count4 = contactsRemarkDao.save(contactsRemark);

            if (count4 != 1) {

                flag = false;

            }

        }


        // (5)线索和市场的关联关系转换成联系人与市场活动的关联关系
        // 查询出与该条线索关联的市场活动，查询与市场活动的关联关系列表
        List<ClueActivityRelation> clueActivityRelationList = clueActivityRelationDao.getListByClueId(clueId);
        // 遍历出每一条与市场活动关联的关联关系记录
        for (ClueActivityRelation clueActivityRelation : clueActivityRelationList) {

            // 从每一条遍历出来的记录中取出关联的市场活动id
            String activityId = clueActivityRelation.getActivityId();

            // 创建联系人与市场活动的关联关系对象，让第三步生成的联系人与市场活动做关联
            ContactsActivityRelation contactsActivityRelation = new ContactsActivityRelation();
            contactsActivityRelation.setId(UUIDUtil.getUUID());
            contactsActivityRelation.setActivityId(activityId);
            contactsActivityRelation.setContactsId(con.getId());

            // 添加联系人与市场活动的关联关系
            int count5 = contactsActivityRelationDao.save(contactsActivityRelation);

            if (count5 != 1) {

                flag = false;

            }

        }

        // (6)如果有创建交易的需求，创建一笔交易
        if (t != null) {

            /*

                t对象在controller里面已经封装好的信息如下：
                    id,money,name,expectedDate,stage,activityId,createTime,createBy

            */
            t.setSource(c.getSource());
            t.setOwner(c.getOwner());
            t.setNextContactTime(c.getNextContactTime());
            t.setDescription(c.getDescription());
            t.setCustomerId(cus.getId());
            t.setContactSummary(c.getContactSummary());
            t.setContactsId(con.getId());

            // 添加交易
            int count6 = tranDao.save(t);

            if (count6 != 1) {

                flag = false;

            }

            // (7)如果创建了交易，则创建一条该交易下的交易历史
            TranHistory th = new TranHistory();
            th.setId(UUIDUtil.getUUID());
            th.setCreateBy(createBy);
            th.setCreateTime(createTime);
            th.setMoney(t.getMoney());
            th.setTranId(t.getId());
            th.setStage(t.getStage());
            th.setExpectedDate(t.getExpectedDate());

            // 添加交易历史
            int count7 = tranHistoryDao.save(th);

            if (count7 != 1) {

                flag = false;

            }
        }

        // (8)删除线索备注
        for (ClueRemark clueRemark : clueRemarkList) {

            int count8 = clueRemarkDao.delete(clueRemark);
            if (count8 != 1) {

                flag = false;

            }

        }

        // (9)删除线索和市场活动的关系
        for (ClueActivityRelation clueActivityRelation : clueActivityRelationList) {

            int count9 = clueActivityRelationDao.delete(clueActivityRelation);

            if (count9 != 1) {

                flag = false;

            }

        }

        // (10)删除线索
        int count10 = clueDao.delete(clueId);

        if (count10 != 1) {

            flag = false;

        }

        return flag;
    }


}
