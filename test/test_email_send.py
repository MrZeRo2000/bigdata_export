
from unittest import TestCase
import smtplib
import email.utils


class TestEmailSend(TestCase):
    def setUp(self) -> None:
        self.__email_from = "noreply@drive-now.com"
        self.__email_to = "roman.pulov@sixt.com"
        self.__email_subject = "Test e-mail"
        self.__smtp_server_address = "172.16.1.25:25"

    def test_send_email(self):
        print("Sending e-mail")

        msg = email.message.Message()
        msg["From"] = self.__email_from
        msg["To"] = self.__email_to
        msg["Subject"] = self.__email_subject

        msg.add_header("Content-type", "text")
        msg.set_payload("My test message")

        smtp = smtplib.SMTP(self.__smtp_server_address)
        smtp.send_message(msg)
        smtp.quit()

        print("E-mail sent")
