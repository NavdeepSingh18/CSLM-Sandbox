tableextension 50550 "tableextension50550" extends "Company Information"
{
    // version NAVW19.00.00.45778,NAVIN9.00.00.45778-CS

    // Sr.No.    Emp. ID       Date          Trigger                   Remarks
    // 1         CSPL-00136    30-04-2019    Director Signature       Field Added .
    fields
    {
        field(50000; "Director Signature"; BLOB)
        {
            Description = 'CS Field Added 02-05-2019';
            SubType = Bitmap;
            DataClassification = CustomerContent;
        }
        field(50001; "Portal Api URL"; Text[2048])
        {
            Description = 'CS Field Added 24-09-20';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Testuser();
            end;
        }
        field(50002; "Portal Sync Enabled"; Boolean)
        {
            Description = 'CS Field Added 24-09-20';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Testuser();
            end;
        }
        field(50003; "Salesforce API Base URL"; Text[2048])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Testuser();
            end;
        }
        field(50004; "Salesforce Token URL"; Text[2048])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Testuser();
            end;
        }
        field(50005; "Salesforce Client Id"; Text[2048])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Testuser();
            end;
        }
        field(50006; "Salesforce Client Secret"; Text[2048])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Testuser();
            end;
        }
        field(50011; "Salesforce Access Token"; Text[2048])
        {
            DataClassification = CustomerContent;
            Caption = 'Salesforce Access Token';
            Description = 'SALESFORCE';
            // trigger OnValidate()
            // begin
            //     Testuser();
            // end;
        }
        field(50012; "AUA Basic Science Img"; BLOB)
        {
            SubType = Bitmap;
            Caption = 'AUA Basic Science Img';
            DataClassification = CustomerContent;
        }
        field(50013; "AUA Image"; BLOB)
        {
            SubType = Bitmap;
            Caption = 'AUA Image';
            DataClassification = CustomerContent;
        }
        field(50014; "AICASA Image"; BLOB)
        {
            SubType = Bitmap;
            Caption = 'AICASA Image';
            DataClassification = CustomerContent;
        }
        field(50015; "Salesforce Sync Enabled"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Salesforce Sync Enabled';
            trigger OnValidate()
            begin
                Testuser();
            end;
        }
        field(50016; "Portal Student Update Api URL"; Text[2048])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Testuser();
            end;
        }
        field(50017; "Portal Student Image Api URL"; Text[2048])
        {
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                Testuser();
            end;
        }
        field(50018; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(50019; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
        field(50020; "SchoolDocs Download URL"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'SchoolDocs Document Download URL TID';
        }
        field(50021; "SchoolDocs Documents Open URL"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'SchoolDocs Documents Open All URL';
        }
        field(50022; "Token URL"; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(50023; "Client ID"; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(50024; "Client Secret"; Text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(50030; "Send Email On/Off"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(50031; "Student Regis. Sync Enable"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Student Registration Sync Enable';
        }
    }

    trigger OnInsert()
    begin
        Inserted := true;
    end;

    trigger OnModify()
    begin
        if xRec.Updated = Updated then
            Updated := true;
    end;

    procedure Testuser()
    var
        UserSetup: Record "User Setup";
    begin
        UserSetup.Get(UserId());
        // if UserSetup."User ID" <> 'AUAUATSRV001\MANIPALADMIN' then
        //if UserSetup."User ID" <> 'CSPL\EPICOR' then
        if not UserSetup."API URLs Allowed" then
            Error('You are not authorized to modify API related information');
    end;
}

