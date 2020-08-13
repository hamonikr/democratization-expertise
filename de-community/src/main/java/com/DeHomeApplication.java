package com;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DeHomeApplication {
	public static boolean running = true;

	
	public static void main(String[] args) throws Exception {
		SpringApplication.run(DeHomeApplication.class, args);
		System.out.println("+++ JavaStopTest started +++");
	    String command = "exit 0";  

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
	
			if (i == 50) {
			// emergency exit
				running = false;
			}
		}
			
			System.out.println("--- JavaStopTest ended ---");
			shellCmd(command);	
		}

	 public static void shellCmd(String command) throws Exception {
         Runtime runtime = Runtime.getRuntime();
         Process process = runtime.exec(command);
         InputStream is = process.getInputStream();
         InputStreamReader isr = new InputStreamReader(is);
         BufferedReader br = new BufferedReader(isr);
         String line;
         while((line = br.readLine()) != null) {
                        System.out.println(line);
         }
	 }
}
