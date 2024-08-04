package org.zerock.ex00.security;

import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

@ExtendWith(SpringExtension.class)
@ContextConfiguration({
        "file:src/main/webapp/WEB-INF/spring/root-context.xml",
        "file:src/main/webapp/WEB-INF/spring/security-context.xml",
})
@Log4j2
public class BCryptTests {

    @Autowired
    PasswordEncoder passwordEncoder;

//    @Test
//    public void test1() {
//        String str = "1111";
//
//        String enStr = passwordEncoder.encode(str);
//
//        log.info(enStr);
//
//        boolean match = passwordEncoder.matches("1111", enStr);
//
//        log.info("match result");
//        log.info(match);
//
//
//    }


//    @Test
//    public void test1() {
//        String password = "1111";
//
//        // 암호화 없이 비밀번호 직접 사용
//        String encodedPassword = password; // 비밀번호를 암호화하지 않음
//
//        log.info("Encoded Password: " + encodedPassword);
//
//        // 비밀번호가 맞는지 직접 비교
//        boolean match = password.equals(encodedPassword);
//
//        log.info("Match result: " + match);
//    }

}
