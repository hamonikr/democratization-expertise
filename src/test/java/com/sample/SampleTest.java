package com.sample;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.Optional;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringRunner;

import com.de.sample.Sample;
import com.de.sample.SampleRepository;
import com.de.sample.SampleService;

@RunWith(SpringRunner.class)
@SpringBootTest
@ActiveProfiles("test")
//@DataJpaTest
public class SampleTest {
	
	@Autowired
	private SampleService ss;
	
	@MockBean
	private SampleRepository sr;
	
//	@Test
//    public void testSaveSample() {
//
//		Sample sample = new Sample("testUser", "test", "testID", "192.168.0.1", "testName");
//		ss.save(sample);
//		Optional<Sample> sample2 = ss.findById(1);
//        assertNotNull(sample);
//        assertEquals(sample2.get().getUserId(), sample.getUserId());
//        assertEquals(sample2.get().getUserName(), sample.getUserName());
//    }
	
	@Test
	public void insert() {
		for(int i = 0; i < 10; i++) {
            Sample sample = Sample.builder()
                    .title("testUser")
                    .contents("test")
                    .userId("testID" + i)
                    .userIp("192.168.0.1")
                    .userName("testName")
                    .build();
            ss.save(sample);
        }
	}
	
//	@Test
//	public void select() {
//		Optional<Sample> sample = ss.findById(1);
//		assertEquals("testName", sample.get().getUserName());
//	}

}
