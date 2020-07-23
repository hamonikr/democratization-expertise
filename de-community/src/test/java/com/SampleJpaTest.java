package com;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.Optional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.jdbc.AutoConfigureTestDatabase;
import org.springframework.boot.test.autoconfigure.orm.jpa.DataJpaTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringRunner;

import com.de.sample.Sample;
import com.de.sample.SampleRepository;

@RunWith(SpringRunner.class)
@DataJpaTest
@ActiveProfiles("test")
@AutoConfigureTestDatabase
public class SampleJpaTest {
	
	@Autowired
	private SampleRepository sr;
	
	@Test
	public void insert() {
		Sample sample = new Sample("title","contents","userId","userName","userIp");
		System.out.println("sample junit Test === insert-->"+sample.toString());
		sr.save(sample);
		Optional<Sample> sample2 = sr.findById(1);
		assertNotNull(sample);
		assertEquals(sample.getContents(), sample2.get().getContents());
	}

}
