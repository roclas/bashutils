// ### Groovy Sample ###
import com.liferay.journal.service.JournalArticleLocalServiceUtil

number = JournalArticleLocalServiceUtil.getCompanyArticlesCount(0L, 0)

System.out.println("Number of Articles: " + number)
