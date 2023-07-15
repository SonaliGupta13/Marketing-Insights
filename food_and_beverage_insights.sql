USE food_and_beverage_industry;

 /* All tables present in database */

    SELECT * FROM dbo.dim_cities;

    SELECT * FROM dbo.dim_repondents;

	SELECT * FROM dbo.fact_survey_responses;

           -- DEMOGRAPHIC INSIGHTS --

      /* Who prefers energy drink more? */

        SELECT Gender, 
		COUNT(Respondent_ID) AS  Total_Respondents
	       FROM dim_repondents
		GROUP BY Gender
		ORDER BY Total_Respondents DESC ;

      /* Which age group prefers energy drinks more? */
	    
		SELECT age, 
		COUNT(Respondent_ID) AS Total_Respondents
		   FROM dim_repondents
		GROUP BY age
		ORDER BY Total_Respondents DESC ;

      /* Which type of marketing reaches the most Youth (15-30)? */
	    
		SELECT Marketing_channels,
		COUNT(*) AS Total_Respondent
		  FROM fact_survey_responses AS f
		  JOIN dim_repondents AS r
		   ON f.Respondent_ID = r.Respondent_ID
		WHERE AGE IN ('15-18' , '19-30')
		GROUP BY Marketing_channels
	    ORDER BY Total_Respondent DESC ;

		             -- CONSUMER PREFERENCES --

       /* What are the preferred ingredients of energy drinks among respondents? */

	      SELECT Ingredients_expected AS Preferred_Ingredients, 
		  COUNT (Respondent_ID) AS Total_Respondent
		    FROM fact_survey_responses
		  GROUP BY Ingredients_expected
		  ORDER BY Total_Respondent DESC ;

	   /*  What packaging preferences do respondents have for energy drinks? */

	      SELECT Packaging_preference,
		  COUNT (Respondent_ID) AS Total_Respondent
		     FROM fact_survey_responses
		  GROUP BY Packaging_preference
		  ORDER BY Total_Respondent DESC ;

		       -- COMPETITION ANALYSIS --

         /* Who are the current market leaders? */

		   SELECT Current_brands AS Current_Marketing_Leaders,
		   COUNT (Respondent_ID) AS Total_Respondents
		       FROM fact_survey_responses
		   GROUP BY Current_brands
		   ORDER BY Total_Respondents DESC ;

        /* What are the primary reasons consumers prefer those brands over ours? */

		   SELECT Reasons_for_choosing_brands AS Other_Brands,
		   COUNT (Respondent_ID) AS Total_Respondents
		       FROM fact_survey_responses
		   GROUP BY Reasons_for_choosing_brands
		   ORDER BY Total_Respondents DESC ;

		             -- MARKETING CHANNELS AND BRAND AWARENESS --

		/* Which marketing channel can be used to reach more customers? */

		   SELECT Marketing_channels,
		   COUNT (*) AS Total_Respondents
		       FROM fact_survey_responses
		   GROUP BY Marketing_channels
		   ORDER BY Total_Respondents DESC ;

         /* How effective are different marketing strategies and channels in reaching our customers? */		  		   SELECT Marketing_channels,
		   COUNT (Respondent_ID) AS Total_Respondents
		       FROM fact_survey_responses
			   WHERE Current_brands = 'CodeX'
		   GROUP BY Marketing_channels
		   ORDER BY Total_Respondents DESC ;		               -- BRAND PENETRATION --		 /* What do people think about our brand? (overall rating) */		  		    WITH overall_rating AS 			 (		        SELECT Brand_perception,		        COUNT(Brand_perception) AS Brand_Count,			    CONCAT(ROUND(100 * COUNT(Brand_perception) / 				SUM(COUNT(Brand_perception)) OVER (),0),'%') AS Rating			       FROM fact_survey_responses			    WHERE Current_brands = 'CodeX'			    GROUP BY Brand_perception			              )                SELECT Brand_perception,Brand_Count,Rating				  FROM overall_rating				ORDER BY Brand_Count DESC ;          /* Which cities do we need to focus more on? */		    SELECT City, Tier,		    COUNT(*) AS Total_Respondents		       FROM dim_cities AS city 		    JOIN dim_repondents AS respondent		    ON city.City_ID = respondent.City_ID		    JOIN fact_survey_responses AS survey		    ON respondent.Respondent_ID = survey.Respondent_ID 		    WHERE Current_brands = 'CodeX'		    GROUP BY City,Tier		    ORDER BY Total_Respondents DESC ;			                -- PURCHASE BEHAVIOR --		   	      /* Where do respondents prefer to purchase energy drinks? */	   	       SELECT Purchase_location,
		   COUNT (Respondent_ID) AS Total_Respondents
		       FROM fact_survey_responses
		   GROUP BY Purchase_location
		   ORDER BY Total_Respondents DESC ;

		 /* What are the typical consumption situations for energy drinks among respondents? */
		   
		   SELECT Typical_consumption_situations,
		   COUNT (Respondent_ID) AS Total_Respondents
		       FROM fact_survey_responses
		   GROUP BY Typical_consumption_situations
		   ORDER BY Total_Respondents DESC ;

		 /*  What factors influence respondents' purchase decisions, such as price range and limited edition packaging? */

		     /* Purchase Decisions */

		   SELECT Price_range,
		   COUNT (Respondent_ID) AS Total_Respondents
		       FROM fact_survey_responses
		   GROUP BY Price_range
		   ORDER BY Total_Respondents DESC ;

		   -- Alter table and update values--
         ALTER TABLE fact_survey_responses
         ALTER COLUMN Limited_edition_packaging VARCHAR(10)

           UPDATE fact_survey_responses
           SET Limited_edition_packaging = 
             CASE
               WHEN Limited_edition_packaging = '1' THEN 'Yes'
               WHEN Limited_edition_packaging = '0' THEN 'No'
               ELSE 'Not Sure'
              END

			   /* Limited Edition */

		   SELECT Limited_edition_packaging,
		   COUNT (Respondent_ID) AS Total_Respondents
		       FROM fact_survey_responses
		   GROUP BY Limited_edition_packaging
		   ORDER BY Total_Respondents DESC ;

		      /* General Perception */

           SELECT General_perception,
		   COUNT (Respondent_ID) AS Total_Respondents
		       FROM fact_survey_responses
		   GROUP BY General_perception
		   ORDER BY Total_Respondents DESC ;

		           -- PRODUCT DEVELOPMENT --

          /* Which area of business should we focus more on our product development? (Branding/taste/availability) */

		    SELECT Reasons_for_choosing_brands,
		    COUNT (Respondent_ID) AS Total_Respondents
		       FROM fact_survey_responses
			   WHERE Current_brands = 'CodeX'
		   GROUP BY Reasons_for_choosing_brands
		   ORDER BY Total_Respondents DESC ;

		       -- SECONDARY INSIGHTS --

		    /* Consumption Reason */

		   SELECT Consume_reason,
		   COUNT (Respondent_ID) AS Total_Respondents
		       FROM fact_survey_responses
			   WHERE Current_brands = 'CodeX'
		   GROUP BY Consume_reason
		   ORDER BY Total_Respondents DESC ;

		   /* Consumption Frequency */

		   SELECT Consume_frequency,
		   COUNT (Respondent_ID) AS Total_Respondents
		       FROM fact_survey_responses
			   WHERE Current_brands = 'CodeX'
		   GROUP BY Consume_frequency
		   ORDER BY Total_Respondents DESC ;

		   
		   /* Preventing for trying Energy Drinks */

		   SELECT Reasons_preventing_trying,
		   COUNT (Respondent_ID) AS Total_Respondents
		       FROM fact_survey_responses
			   WHERE Current_brands = 'CodeX'
		   GROUP BY Reasons_preventing_trying
		   ORDER BY Total_Respondents DESC ;

		          -- RECOMMENDATIONS --

         /* What immediate improvements can we bring to the product? */

		    SELECT Improvements_desired,
		    COUNT (Respondent_ID) AS Total_Respondents
		       FROM fact_survey_responses
			   WHERE Current_brands = 'CodeX'
		    GROUP BY Improvements_desired
		    ORDER BY Total_Respondents DESC ;

        /* What should be the ideal price of our product? */

		     SELECT Price_range,
		    COUNT (Respondent_ID) AS Total_Respondents
		       FROM fact_survey_responses
			   WHERE Current_brands = 'CodeX'
		    GROUP BY Price_range
		    ORDER BY Total_Respondents DESC ;

		/* What kind of marketing campaigns, offers, and discounts we can run? */
		    SELECT Marketing_channels,
		    COUNT (Respondent_ID) AS Total_Respondents
		       FROM fact_survey_responses
			   WHERE Current_brands = 'CodeX'
		    GROUP BY Marketing_channels
		    ORDER BY Total_Respondents DESC ;
		