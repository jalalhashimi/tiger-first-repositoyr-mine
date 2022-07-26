package tiger.api.test.data;


import java.text.SimpleDateFormat;
import java.util.Date;

import com.github.javafaker.Faker;



public class FakeData {

	//Generate a fake email
	public static String getEmail() {
		Faker fake = new Faker();
		return fake.name().firstName() + fake.name().lastName() + "@gmail.com";
	}
	public static String getFirstName() {
		Faker fake = new Faker();
		return fake.name().firstName();
	}
	public static String getLastName() {
		Faker fake = new Faker();
		return fake.name().lastName();
	}
	public static String getPhoneNumber() {
		Faker fake = new Faker();
		return fake.phoneNumber().cellPhone();
	}
	public static String getDOB() {
		Faker fake = new Faker();
		Date date1 = fake.date().birthday();
		SimpleDateFormat format1 = new SimpleDateFormat("yyyy-mm-dd");
		return format1.format(date1);
	}
}
