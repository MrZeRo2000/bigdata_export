
import smtplib
import email


class EmailSender:
    def __init__(self, smtp_server_address, email_from, email_to, email_subject):
        self._smtp_server_address = smtp_server_address
        self._email_from = email_from
        self._email_to = email_to
        self._email_subject = email_subject

    def send_content(self, content: str):
        msg = email.message.Message()

        msg["From"] = self._email_from
        msg["To"] = self._email_to
        msg["Subject"] = self._email_subject

        msg.add_header("Content-type", "text/html")
        msg.add_header("charset", "utf-8")
        msg.set_payload(content)

        smtp = smtplib.SMTP(self._smtp_server_address)
        smtp.send_message(msg)
        smtp.quit()
