package com;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.context.junit4.SpringRunner;

import com.de.sample.Sample;
import com.sample.SampleRepositoryTest;

@RunWith(SpringRunner.class)
@SpringBootTest(classes = { DeHomeApplication.class, H2TestProfileJPAConfig.class })
@ActiveProfiles("test")
public class SpringBootProfileIntegrationTest {
	
	@Autowired
    private SampleRepositoryTest genericEntityRepository;

    @Test
    public void givenGenericEntityRepository_whenSaveAndRetreiveEntity_thenOK() {
        //Sample genericEntity = genericEntityRepository.save(new Sample("test1","testcontents","testID","testName","192.168.0.1"));
        //Sample foundEntity = genericEntityRepository.findById(genericEntity.getSeq()).orElse(null);
        //assertNotNull(foundEntity);
        //assertEquals(genericEntity.getTitle(), foundEntity.getTitle());
    }

}
