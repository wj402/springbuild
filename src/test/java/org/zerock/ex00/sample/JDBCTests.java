package org.zerock.ex00.sample;

import org.junit.jupiter.api.Test;

import java.sql.Connection;
import java.sql.DriverManager;

public class JDBCTests {

    @Test
    public void testConnection() throws Exception {

        // DB Driver Class
        Class.forName("org.mariadb.jdbc.Driver");

        // URL
         Connection connection = DriverManager.getConnection("jdbc:mariadb://localhost:3306/springdb",
                "springdbuser",
                "springdbuser");

        System.out.println(connection);

        //username/password

        connection.close();


    }

    @Test
    public void testRegExp() {
        String suffix = "jpeg";

        String regExp = "^(jpg|jpeg|JPG|JPEG|png|PNG|gif|GIF|bmp|BMP)";

        System.out.println(suffix.matches(regExp));
    }

}
