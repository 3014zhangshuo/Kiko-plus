---
layout: post
title: "AES-128-GCM 加密算法在 ruby 和 java 中的不同"
date: 2021-04-16
tags: [ruby, java]
---


```java
import java.io.UnsupportedEncodingException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.sql.Timestamp;
import java.util.Base64;
import java.util.Date;
import java.util.Scanner;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.KeyGenerator;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.SecretKey;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;

public class AESUtil {

    public static class GCM128 {

      	public static final int AES_KEY_SIZE = 128;
      	public static final int GCM_IV_LENGTH = 12;
      	public static final int GCM_TAG_LENGTH = 16;

      	public static byte[] encrypt(byte[] plaintext, byte[] enckey, byte[] IV) throws Exception {
      		// Get Cipher Instance
      		Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");

      		// Create SecretKeySpec
      		SecretKeySpec keySpec = new SecretKeySpec(enckey, "AES");

      		// Create GCMParameterSpec
      		GCMParameterSpec gcmParameterSpec = new GCMParameterSpec(GCM_TAG_LENGTH * 8, IV);

      		// Initialize Cipher for ENCRYPT_MODE
      		cipher.init(Cipher.ENCRYPT_MODE, keySpec, gcmParameterSpec);

      		// Perform Encryption
      		byte[] cipherText = cipher.doFinal(plaintext);

      		return cipherText;
      	}

        public static byte[] decrypt(byte[] cipherText, byte[] deckey, byte[] IV) throws Exception {
          // Get Cipher Instance
          Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");

          // Create SecretKeySpec
          SecretKeySpec keySpec = new SecretKeySpec(deckey, "AES");

          // Create GCMParameterSpec
          GCMParameterSpec gcmParameterSpec = new GCMParameterSpec(GCM_TAG_LENGTH * 8, IV);

          // Initialize Cipher for DECRYPT_MODE
          cipher.init(Cipher.DECRYPT_MODE, keySpec, gcmParameterSpec);

          // Perform Decryption
          byte[] decryptedText = cipher.doFinal(cipherText);

          return decryptedText;
        }
      }

      public static String parseByte2HexStr(byte buf[]) {
      StringBuffer sb = new StringBuffer();
      for (int i = 0; i < buf.length; i++) {
        String hex = Integer.toHexString(buf[i] & 0xFF);
        if (hex.length() == 1) {
          hex = '0' + hex;
        }
        sb.append(hex.toUpperCase());
      }
      return sb.toString();
    }

    public static byte[] parseHexStr2Byte(String hexStr) {
        if (hexStr.length() < 1)
            return null;
        byte[] result = new byte[hexStr.length() / 2];
        for (int i = 0; i < hexStr.length() / 2; i++) {
            int high = Integer.parseInt(hexStr.substring(i * 2, i * 2 + 1), 16);
            int low = Integer.parseInt(hexStr.substring(i * 2 + 1, i * 2 + 2), 16);
            result[i] = (byte) (high * 16 + low);
        }
        return result;
    }

    public static void main(String[] args) throws Exception {
        String key = "Udesk*A8B6C4D2E0";

        byte[] IV = parseHexStr2Byte("cb88b72bb76eecae94e9d013");
        long time = Timestamp.valueOf("2022-03-19 12:10:10").getTime();

  // 		String text = "1";

  //    byte[] cipherText = GCM128.encrypt(text.getBytes(), key.getBytes(), IV);
  //    System.out.println("Encrypted Text : " + parseByte2HexStr(cipherText));

        byte[] cipherText = parseHexStr2Byte("ac5c1ab5f263cf5a8f84711fbf4da930ebfd75e8b62bd858e56cdf8e23319bf9e78b923be46493a42f3be7f092debd52081f1d21d9da9f361213a421653157f0cd417ed4e0e4794179717bbacccb897e5ce2f59bebc5169df67519897196072f7e3086cd389023d5f8de173231faeb88d53d864d16db454c8fe3ee715e8fb8afbc73da031430c74d8c7ab5d22838b19923c88a94056ef21efad7b1bff294e0eba4982d0eb1fcde8ca9485b909057ad3a8c63f73e1c5c791209ff2610ee8a7a2dbca5a2fafde9d7ea0a9ab7a5dade9c256d1bc8ae1d8cffd9fcab0e62c7fad808839cce1f3dd0b0da9f4a522f9b086666f9f10872739148c926daf5f4977f66f8cfc1c315ac9cf12fef80f6a7e6eea8331f6a78d8d7428685");
        byte[] decryptedText = GCM128.decrypt(cipherText, key.getBytes(), IV);
        System.out.println("DeCrypted Text : " + new String(decryptedText));
    }
}
```

```ruby
def aes_128_gcm_encrypted_result
  cipher = OpenSSL::Cipher.new('AES-128-GCM')
  cipher.encrypt
  iv = cipher.random_iv
  hex_iv = iv.unpack("H*").first

  cipher.key = "Udesk*A8B6C4D2E0"
  cipher.iv = iv
  cipher.padding = 0
  cipher.auth_data = ""

  ciphertext = cipher.update(user_data_v2(iv).to_json)
  ciphertext << cipher.final
  ciphertext << cipher.auth_tag

  [ciphertext.unpack("H*").first, hex_iv]
end
```

java 的加密结果 密文和 auth_tag(默认是 16 bytesize) 是混在一起的，ruby 实现的话要注意这一点

---

* [online-java-compiler](https://www.jdoodle.com/online-java-compiler/)
* [implement_encryption_decryption_by_aes_gcm](https://noknow.info/it/ruby/implement_encryption_decryption_by_aes_gcm?lang=en)
* [ruby-gcm-nonce-reuse-language-sets-fail](https://adamcaudill.com/2016/09/19/ruby-gcm-nonce-reuse-language-sets-fail/)
* [java-aes-encryption-and-decryption](https://mkyong.com/java/java-aes-encryption-and-decryption/)
