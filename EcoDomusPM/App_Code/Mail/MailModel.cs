using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for MailModel
/// </summary>
/// 
namespace EcoDomus.Mail.Model
{
    public class MailModel
    {
        public MailModel()
        {
            //
            // TODO: Add constructor logic here
            //
        }
        private string strMessageBody;

        public string MessageBody
        {
            get { return strMessageBody; }
            set { strMessageBody = value; }
        }

        private string strSubject;

        public string Subject
        {
            get { return strSubject; }
            set { strSubject = value; }
        }


        private string strSender;

        public string Sender
        {
            get { return strSender; }
            set { strSender = value; }
        }
        private string strReceiver;

        public string Receiver
        {
            get { return strReceiver; }
            set { strReceiver = value; }
        }

        private bool isBodyHtml;

        public bool IsBodyHtml
        {
            get { return isBodyHtml; }
            set { isBodyHtml = value; }
        }
    }
}