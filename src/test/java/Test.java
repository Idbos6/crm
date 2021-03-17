import com.node.crm.utils.MD5Util;

public class Test {

    public static void main(String[] args) {


        String pwd = "q13212445760";

        String pwd1 = MD5Util.getMD5(pwd);

        System.out.println(pwd1);




    }

}
