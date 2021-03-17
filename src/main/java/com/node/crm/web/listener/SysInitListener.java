package com.node.crm.web.listener;

import com.node.crm.settings.domain.DicValue;
import com.node.crm.settings.service.DicService;
import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.stereotype.Component;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.*;

@Component
public class SysInitListener implements ServletContextListener, ApplicationContextAware {

    private static ApplicationContext applicationContext;

    /*

        该方法是用来监听上下文域对象的方法，当服务器启动，上下文域对象创建
        对象创建完毕后，马上执行该方法

        event:该参数能够取得监听的对象
                监听的是什么对象，就可以通过该参数取得什么对象
                例如我们现在监听的是上下文域对象，通过该参数就可以取得上下文域对象

     */
    @Override
    public void contextInitialized(ServletContextEvent event) {

        System.out.println("服务器缓存处理数据字典开始");
        ServletContext application = event.getServletContext();
        DicService ds = applicationContext.getBean(DicService.class);
        /*
            应该管业务层要
            7个list

            可以打包成一个map
            业务层应该是这样来保存数据的
                map.put("appellationList",dvList1);
                map.put("clueStageList",dvList2);
                map.put("stageList",dvList3);
                ....
                ..
         */
        Map<String, List<DicValue>> map = ds.getAll();
        // 将map解析为上下文域对象保存的键值对
        Set<String> set = map.keySet();

        for (String key : set) {

            application.setAttribute(key, map.get(key));

        }
        System.out.println("服务器缓存处理数据字典结束");

        //------------------------------------------------------------

        // 数据字典处理完毕后，处理Stage2Possibility.properties文件


        /*

            处理Stage2Possibility.properties文件步骤：
                解析该文件，将该属性文件中的键值对关系处理成为java中键值对关系（map）

                Map<String(阶段stage), String(可能性possibility)> pMap = ....
                pMap.put("01资质审查",10);
                pMap.put("02需求分析",25);
                pMap.put("07...",...);

                pMap保存值之后，放在服务器缓存中
                application.setAttribute("pMap", pMap);

        */

        // 解析properties文件
        // Properties的处理方式是将其作为一个映射表,而且这个类表示了一个持久的属性集,
        // 他是继承HashTable这个类。ResourceBundle本质上也是一个映射，但是它提供了国际化的功能。

        Map<String, String> pMap = new HashMap<>();

        ResourceBundle rb = ResourceBundle.getBundle("conf/Stage2Possibility");

        Enumeration<String> e = rb.getKeys();

        while (e.hasMoreElements()) {

            // 阶段
            String key = e.nextElement();

            // 可能性
            String value = rb.getString(key);

            pMap.put(key, value);
        }

        // 将pMap保存到服务器缓存中
        application.setAttribute("pMap", pMap);

    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {

    }

    @Override
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {

        SysInitListener.applicationContext = applicationContext;

    }

}
