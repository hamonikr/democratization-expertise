package com.hamonize.cmmn.util;


import java.io.UnsupportedEncodingException;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.commons.codec.DecoderException;
import org.apache.commons.codec.binary.Base64;
import org.apache.commons.codec.binary.Hex;
import org.apache.commons.codec.binary.StringUtils;


public class AESCipherUtils {

	static private String KEY = "E7544B89ADABEAE7";
	static byte[] bIv = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
			0x10 };

	static SecretKeySpec secureKey = new SecretKeySpec(KEY.getBytes(), "AES");
	static IvParameterSpec iv = new IvParameterSpec(bIv);

	private static byte[] encript(String str) {
		Cipher cipher;
		try {
			cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			cipher.init(Cipher.ENCRYPT_MODE, secureKey, iv);
			return cipher.doFinal(str.getBytes("UTF-8"));
		} catch (NoSuchAlgorithmException | NoSuchPaddingException | InvalidKeyException
				| InvalidAlgorithmParameterException | IllegalBlockSizeException | BadPaddingException
				| UnsupportedEncodingException e) {
			throw CodeMessage.ERROR_000003_암호화_오류입니다_.toException();
		}
	}


	public static String encriptHex(String str) {
		return new String(Hex.encodeHex(encript(str))).toUpperCase();
	}


	public static String encriptBase64(String str) {
		return StringUtils.newStringUtf8(Base64.encodeBase64(encript(str), false));
	}


	public static String decript(String str) {
		return decript(new java.math.BigInteger(str, 16).toByteArray());
	}


	public static String decriptBase64(String str) {
		return decript(Base64.decodeBase64(str));
	}


	public static String decriptHex(String str) {
		try {
			return decript(Hex.decodeHex(str.toCharArray()));
		} catch (DecoderException e) {
			throw CodeMessage.ERROR_000003_암호화_오류입니다_.toException();
		}
	}


	public static String decript(byte[] b) {
		try {
			Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
			cipher.init(Cipher.DECRYPT_MODE, secureKey, iv);
			return new String(cipher.doFinal(b));
		} catch (NoSuchAlgorithmException | NoSuchPaddingException | InvalidKeyException
				| InvalidAlgorithmParameterException | IllegalBlockSizeException | BadPaddingException e) {
			throw CodeMessage.ERROR_000003_암호화_오류입니다_.toException();
		}
	}

//	public static void main(String[] args) throws Exception {
//		System.out.println(AESCipherUtils.encriptBase64("Jang"));
//		System.out.println(AESCipherUtils.decriptBase64("ajdFQP7bGuwCcWoJOwkiyg=="));
//	}

}
