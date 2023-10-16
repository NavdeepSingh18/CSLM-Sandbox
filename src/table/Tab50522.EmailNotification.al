table 50522 "Email Notification"
{
    Caption = 'E-mail Notification';
    DataClassification = CustomerContent;


    fields
    {
        field(1; Id; Integer)
        {
            Caption = 'Id';
            DataClassification = CustomerContent;

        }
        field(2; Type; Text[50])
        {
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(3; "Sender Name"; text[100])
        {
            Caption = 'Sender Name';
            DataClassification = CustomerContent;
        }
        field(4; SenderId; text[50])
        {
            Caption = 'Sender Id';
            DataClassification = CustomerContent;
        }
        field(6; ReceiverName; Text[150])
        {
            Caption = 'Receiver Name';
            DataClassification = CustomerContent;
        }
        field(7; ReceiverId; text[50])
        {
            Caption = 'Receiver Id';
            DataClassification = CustomerContent;
        }
        field(8; Subject; Text[200])
        {
            Caption = 'Subject';
            DataClassification = CustomerContent;
        }
        field(9; Text_; Text[2048])
        {
            Caption = 'Text';
            DataClassification = CustomerContent;
        }
        field(10; Process; Text[100])
        {
            caption = 'Process';
        }
        field(11; Event_; text[100])
        {
            Caption = 'Event';
            DataClassification = CustomerContent;
        }
        field(12; "Process No"; Text[100])
        {
            Caption = 'Process No';
            DataClassification = CustomerContent;
        }
        field(13; EDate; DateTime)
        {
            Caption = 'End DateTime';
            DataClassification = CustomerContent;
        }
        field(14; "Receiver Email Id"; text[100])
        {
            DataClassification = CustomerContent;
        }

        field(15; "Send Email"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(16; "Email Sent"; Integer)
        {
            Caption = 'Email Sent';
            DataClassification = CustomerContent;
        }
        field(17; "Email Sent Datetime"; DateTime)
        {
            caption = 'Email Sent Date time';
            DataClassification = CustomerContent;
        }
        field(18; "Mail Item Id"; Integer)
        {
            Caption = 'Mail Item Id';
            DataClassification = CustomerContent;
        }
        field(19; "Mobile No"; text[20])
        {
            Caption = 'Mobile No';
            DataClassification = CustomerContent;
        }
        field(20; "Sms Text"; text[500])
        {
            Caption = 'Sms Text';
            DataClassification = CustomerContent;
        }
        field(21; "Send Sms"; Integer)
        {
            Caption = 'Send Sms';
            DataClassification = CustomerContent;
        }
        field(22; "Sms Sent"; Integer)
        {
            Caption = 'Sms Sent';
            DataClassification = CustomerContent;
        }
        field(23; "Sms Sent Datetime"; DateTime)
        {
            Caption = 'Sms Sent Datetime';
            DataClassification = CustomerContent;
        }
        field(24; "Notification Sent By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        Field(25; PortalMail; Boolean)
        {
            DataClassification = CustomerContent;
        }
        Field(26; PortalID; Integer)
        {
            DataClassification = CustomerContent;
        }

        Field(27; "File Attachment"; Blob)
        {
            DataClassification = CustomerContent;
        }
        Field(28; Address; Text[250])
        {
            DataClassification = CustomerContent;
        }

    }

    keys
    {
        key(PK; Id)
        {
        }
        key(Key1; "Email Sent Datetime")
        { }
    }


}