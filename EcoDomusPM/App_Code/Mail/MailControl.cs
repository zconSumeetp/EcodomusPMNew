using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using EcoDomus.Mail.Model;
using System.Data;
/// Summary description for MailControl
/// </summary>
namespace EcoDomus.Mail.Control
{
    public class MailControl
    {
        public MailControl()
        {

        }
        public string SendMail(MailModel mailModel)
        {

            Chilkat.Email email = new Chilkat.Email();
            Chilkat.MailMan mailman = new Chilkat.MailMan();
            mailman.UnlockComponent("ZCONSOLUTIMAILQ_LxuHowmg7I9E");
            DataSet ds_email = new DataSet();

            // The SMTP username and password are only necessary if
            // your SMTP server requires authentication.
            mailman.SmtpHost = "smtp.googlemail.com";
            mailman.SmtpUsername = "support@ecodomus.com";
            mailman.SmtpPassword = "ecosupport01";

            mailman.SmtpPort = 465;
            string FromMailId = mailModel.Sender;
            email.SetHtmlBody(mailModel.MessageBody);
            email.Subject = mailModel.Subject;
            email.AddTo("", mailModel.Receiver);
            email.From = mailModel.Sender;
            bool success;
            string result = string.Empty;
            success = mailman.SendEmail(email);

            if (success)
            {
                result = "Mail sent successfully";
            }
            else
            {
                result = mailman.LastErrorHtml;
            }
            return result;
        }
    }
}