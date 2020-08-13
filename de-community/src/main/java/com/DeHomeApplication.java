package com;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DeHomeApplication {
	public static boolean running = true;

	
	public static void main(String[] args) {
		SpringApplication.run(DeHomeApplication.class, args);
		System.out.println("+++ JavaStopTest started +++");
		Runtime.getRuntime().addShutdownHook(new MyShutdownHook());

		int i = 0;
	
		while (running) {
			System.out.println("count=" + i);
			i++;

		try {
			Thread.sleep(1000);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
	
			if (i == 100) {
			// emergency exit
				running = false;
			}
		}

			System.out.println("--- JavaStopTest ended ---");
		}

	
}
