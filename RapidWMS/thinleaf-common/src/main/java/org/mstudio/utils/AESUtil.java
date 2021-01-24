package org.mstudio.utils;

import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import java.security.SecureRandom;
import java.util.Base64;

public class AESUtil {

    private static final String ALGORITHM = "AES";
    private static final String KEY = "wudao9527";

    private static SecretKey geneKey(String key) throws Exception {
        KeyGenerator keyGenerator = KeyGenerator.getInstance(ALGORITHM);
        SecureRandom random = new SecureRandom();
        random.setSeed(key.getBytes());
        keyGenerator.init(random);
        SecretKey secretKey = keyGenerator.generateKey();
        return secretKey;
    }

    private static SecretKey geneKey() throws Exception {
        return geneKey(KEY);
    }

    public static String encrypt(String content) throws Exception {
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        SecretKey secretKey = geneKey();
        cipher.init(Cipher.ENCRYPT_MODE, secretKey);
        cipher.update(content.getBytes());
        byte[] result = cipher.doFinal();
        return Base64.getEncoder().encodeToString(result);
    }

    /**
     * 解密测试
     */
    public static String decrpyt(String content) throws Exception {
        Cipher cipher = Cipher.getInstance(ALGORITHM);
        SecretKey secretKey = geneKey();
        cipher.init(Cipher.DECRYPT_MODE, secretKey);
        byte[] encodedBytes = Base64.getDecoder().decode(content.getBytes());
        byte[] result = cipher.doFinal(encodedBytes);
        return new String(result);
    }
}
