package com.catpics;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.URL;

import javax.imageio.ImageIO;
import javax.servlet.http.*;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.concurrent.ThreadLocalRandom;

public class CatPics extends HttpServlet {

	private static final long serialVersionUID = 1L;
	private static final Logger logger = LoggerFactory.getLogger(CatPics.class);

	public void doGet(HttpServletRequest request,HttpServletResponse response) throws IOException {
		
		String[] images = {
			"https://img.buzzfeed.com/buzzfeed-static/static/2013-10/enhanced/webdr01/15/9/anigif_enhanced-buzz-31540-1381844535-8.gif",
			"https://img.buzzfeed.com/buzzfeed-static/static/2013-10/enhanced/webdr05/15/9/anigif_enhanced-buzz-26388-1381844103-11.gif",
			"https://img.buzzfeed.com/buzzfeed-static/static/2013-10/enhanced/webdr05/15/9/anigif_enhanced-buzz-26390-1381844163-18.gif"
		};

		int random = ThreadLocalRandom.current().nextInt(0, images.length);
		logger.debug("Generated this awesome number: {}", random);
		
		try {
			BufferedImage catPic = ImageIO.read(new URL(images[random]));
			response.setContentType("image/gif");
			OutputStream out = response.getOutputStream();
			ImageIO.write(catPic, "gif", out);
			out.close();
		}
		catch (IOException e) {
			// Ignore expetion
			logger.debug("IOException encountered. We ignore it since it's just because the client closed the conneection prematurely.");
		}
	}
}
