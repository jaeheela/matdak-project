package xyz.itwill.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.UUID;
import java.util.regex.Pattern;


//웹프로그램 작성에 필요한 부가적인 기능을 제공하기 위한 클래스
public class Utility {
	//문자열을 전달받아 암호화 처리하여 반환하는 메소드
	public static String encrypt(String source) { //테이블에 저장되기 전 사용
		//암호화 처리된 문자열을 저장하기 위한 변수 선언
		String password="";
		try {
			//MessageDigest 객체 : 암호화 처리 기능을 제공하는 객체
			//=> 싱글톤 클래스 new 연산자로 객체 생성 불가능
			//MessageDigest.getInstance(String algorithm) : 매개변수에 전달된 암호화 알고리즘이 저장된 MessageDigest 객체를 생성하여 반환하는 메소드
			//=> 매개변수에 잘못된 암호화 알고리즘을 전달할 경우 NoSuchAlgorithmException 발생
			//단방향 암호화 알고리즘 : MD5(비권장), SHA-1, SHA-256(SHA-256 이상 쓰는걸 권장), SHA-512 등, 원상태로 복구 불가능
			//양방향 암호화 알고리즘 : AES-123, RSA 등, 원상태로 복구 가능
 			MessageDigest messageDigest=MessageDigest.getInstance("SHA-256");
 			
 			//MessageDigest.update(byte[] input) : MessageDigest 객체에 암호화 처리하기 위해 값(byte 배열)을 전달받아 저장하기 위한 메소드
 			//String.getBytes() : String 객체에 저장된 문자열을 원시데이터(byte 배열)로 변환하여 반환하는 메소드
 			messageDigest.update(source.getBytes());
 			
 			//MessageDigest.digest() : MessageDigest 객체에 저장된 암호화 알고리즘으로 원시데이터를 암호화 처리하여 byte 배열로 반환하는 메소드
 			byte[] digest=messageDigest.digest();
 			
 			//암호화 처리된 byte 배열(숫자값)을 문자열(String 객체)로 변환하여 저장
 			for(int i=0;i<digest.length;i++) {
 				//Integer.toHexString(int i) : 정수값을 전달받아 16진수의 문자열로 변환하여 반환하는 메소드
 				password+=Integer.toHexString(digest[i]&0xff); //논리곱연산자 - 부호비트 없앰
 			}
		}catch (NoSuchAlgorithmException e) {
			System.out.println("[에러]잘못된 암호화 알고리즘을 사용하였습니다.");
		}
		return password;
	}
	
	//문자열을 전달받아 태그 관련 문자열을 모두 제거하여 반환하는 메소드
	public static String stripTag(String source) {
		//Pattern.compile(String regex) : 정규표현식이 저장된 Pattern 객체를 반환하는 메소드
		//Pattern 객체 : 정규표현식 관련 기능을 제공하기 위한 객체
		Pattern htmlTag=Pattern.compile("\\<.*?\\>");
		
		//Pattern.matcher(CharSequence input) : Pattern 객체에 저장된 정규표현식과 입력값이 저장된 Matcher 객체를 반환하는 메소드
		//=>CharSequence : 스트링이나 스트링버퍼의 부모
		//Matcher 객체 : 정규표현식과 입력값을 비교 처리하기 위한 기능을 제공하는 객체
		//Matcher.replaceAll(String replacement) : 정규표현식과 입력값을 비교하여 패턴이 동일한 문자열을 모두 찾아 매개변수로 전달받은 문자열로 변경하는 메소드
		source=htmlTag.matcher(source).replaceAll("");
		
		return source;
	}
	
	//문자열을 전달받아 태그 관련 문자를 회피문자로 변경하여 반환하는 메소드
	public static String escapeTag(String source) {
		return source.replace("<", "&lt;").replace(">", "&gt");
	}
	
	//랜덤 비밀번호 출력
	public static String newPassWordTwo() {
		return UUID.randomUUID().toString().replace("-","").substring(0,10).toUpperCase();
	}
	
}

//<font size="7">하하하</font>