table 50516 "MSPE"
{
    DataClassification = CustomerContent;
    Caption = 'MSPE';
    // LookupPageId = "MSPE Application Card";
    // DrillDownPageId = "MSPE Application Card";
    DataCaptionFields = "Application No", "First Name";

    fields
    {
        field(1; "Application No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Application No';
        }
        field(2; "Application Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Application Date';
        }
        field(3; "Application Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Application Type';
            OptionCaption = ' ,New,Repeated';
            OptionMembers = " ",New,Repeated;
        }
        field(4; "Student No"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student No';
            TableRelation = "Student Master-CS"."No.";
            trigger OnValidate();
            begin
                if StudentMasterRec.Get("Student No") then begin
                    Semester := StudentMasterRec.Semester;
                    "Academic Year" := StudentMasterRec."Academic Year";
                    Term := StudentMasterRec.Term;
                    "last Name" := StudentMasterRec."Last Name";
                    "First Name" := StudentMasterRec."First Name";
                    //  Address := StudentMasterRec.Address1;
                    Country := StudentMasterRec."Country Code";
                    City := StudentMasterRec.City;
                    State := StudentMasterRec.State;
                    Zip := StudentMasterRec."Post Code";
                    "Phone Numbers" := StudentMasterRec."Phone Number";
                    Mobile_Cell := StudentMasterRec."Mobile Number";
                    "AUA Email Address" := StudentMasterRec."E-Mail Address";
                end else begin
                    Semester := '';
                    "Academic Year" := '';
                    "First Name" := '';
                    "Last Name" := '';
                    Clear(Term);
                    Address := '';
                    Country := '';
                    City := '';
                    State := '';
                    Zip := '';
                    "Phone Numbers" := '';
                    Mobile_Cell := '';
                end;
            end;
        }
        field(5; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";

        }
        field(6; Semester; Code[20])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(7; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING';
            OptionMembers = FALL,SPRING;
        }
        field(8; "Step 1 Agree"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Step 1 Agree';
        }
        field(9; "Last Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Name';
        }
        field(10; "First Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'First Name';
        }
        field(11; "Previous Last Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Previous Last Name';
        }
        field(12; "Previous First Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Previous First Name';
        }
        field(13; "Phone Numbers"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Phone Numbers';
        }
        field(14; "Mobile_Cell"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Mobile_Cell';
        }
        field(15; "Address"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Mailing Address';
        }
        field(16; "Country"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Country';
        }
        field(17; "State"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'State';
        }
        field(18; "City"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'City';
        }

        field(19; "Zip"; Text[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Zip';
        }

        field(20; "ERAS"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'ERAS';
        }

        field(21; "CaRMS"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'CaRMS';
        }
        field(22; "Other Specialty"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Other Specialty';
        }

        field(23; "Other Specialty Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Other Specialty Description';
        }
        field(24; "1st Noteworthy Char. Exp."; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = '1st Noteworthy Characteristics Exp.';
        }

        field(25; "1st Noteworthy Char. Dates"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = '1st Noteworthy Characteristics Start Date';
        }

        field(26; "1st Noteworthy Char. Location"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = '1st Noteworthy Characteristics Location';
        }
        field(27; "2nd Noteworthy Char. Exp."; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = '2nd Noteworthy Characteristics Exp.';
        }

        field(28; "2nd Noteworthy Char Dates"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = '2nd Noteworthy Characteristics Start Date';
        }

        field(29; "2nd Noteworthy Char Location"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = '2nd Noteworthy Characteristics Location';
        }

        field(30; "3rd Noteworthy Char. Exp."; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = '3rd Noteworthy Characteristics Exp.';
        }

        field(31; "3rd Noteworthy Char Dates"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = '3rd Noteworthy Characteristics Start Date';
        }
        field(32; "3rd Noteworthy Char Location"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = '3rd Noteworthy Characteristics Location';
        }

        field(33; "4th Noteworthy Char Exp."; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = '4th Noteworthy Characteristics Exp.';
        }

        field(34; "4th Noteworthy Char Dates"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = '4th Noteworthy Characteristics Start Date';
        }

        field(35; "4th Noteworthy Char Location"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = '4th Noteworthy Characteristics Location';
        }

        field(36; "5th Noteworthy Char Exp."; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = '5th Noteworthy Characteristics Exp.';
        }

        field(37; "5th Noteworthy Char Dates"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = '5th Noteworthy Characteristics Start Date';
        }

        field(38; "5th Noteworthy Char Location"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = '5th Noteworthy Characteristics Location';
        }

        field(39; "Under Graduate School Name"; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Under Graduate School Name';
        }

        field(40; "Under Graduate Location"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Under Graduate Location';
        }
        field(41; "Under Graduate Month Year"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Under Graduate Month Year';
        }

        field(42; "Under Graduate Degree"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Under Graduate Degree';
        }

        field(43; "Under Graduate Degree Major"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Under Graduate Degree Major';
        }

        field(44; "Field of Study"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Field of Study';
        }

        field(45; "Post Graduate_Curr Pos_Dep"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Post Graduate_Current Position_Department';
        }

        field(46; "Post Graduate_Curr Hosp_Inst"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Post Graduate_Current Hospital_Institution';
        }

        field(47; "Post Graduate_Curr City_State"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Post Graduate_Current City_State';
        }

        field(48; "Post Graduate_Current From"; text[7])
        {
            DataClassification = CustomerContent;
            Caption = 'Post Graduate_Current From';

        }

        field(49; "Post Graduate_Current To"; text[7])
        {
            DataClassification = CustomerContent;
            Caption = 'Post Graduate_Current To';
        }

        field(50; "Do Not Update MPSE"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Do Not Update MPSE';
        }

        field(51; "Application Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Application Status';
            OptionCaption = ' ,Draft,Confirmed';
            OptionMembers = " ",Draft,Confirmed;
        }
        field(52; "Processing Status"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Processing Status';
            OptionCaption = ' ,Pending,In-Progress,In-Review,Review Required,Completed';
            OptionMembers = " ",Pending,"In-Progress","In-Review","Review Required",Completed;
        }

        field(53; "Creation On"; Date)
        {
            DataClassification = CustomerContent;
            //Editable = false;
        }
        field(54; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            //Editable = false;
        }
        field(55; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
            //Editable = false;
        }
        field(56; "Modified By"; Text[50])
        {
            DataClassification = CustomerContent;
            //Editable = false;
        }
        field(57; "Completed Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(58; "1st Noteworthy Char. End Date"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = '1st Noteworthy Characteristics End Date';
        }
        field(59; "2nd Noteworthy Char. End Date"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = '2nd Noteworthy Characteristics End Date';
        }
        field(60; "3rd Noteworthy Char. End Date"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = '3rd Noteworthy Characteristics End Date';
        }
        field(61; "4th Noteworthy Char. End Date"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = '4th Noteworthy Characteristics End Date';
        }
        field(62; "5th Noteworthy Char. End Date"; Text[20])
        {
            DataClassification = CustomerContent;
            Caption = '5th Noteworthy Characteristics End Date';
        }
        field(63; Remarks; Text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'Remarks';
        }
        field(64; "Step 2 Agree"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(65; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }

        field(66; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }

        // Field(67; Apt; Text[30])
        // {
        //     Caption = 'Apt #';
        //     DataClassification = CustomerContent;
        // }

        // field(68; "Phone Number - Home"; Text[30])
        // {
        //     DataClassification = CustomerContent;
        // }
        // field(69; Cell; Text[30])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Cell #';
        // }
        field(50204; "Estimated Graduation Date"; Date)
        {
            Caption = 'Estimated Graduation Date';
            DataClassification = CustomerContent;
        }
        field(50205; "AUA Email Address"; text[80])
        {
            DataClassification = CustomerContent;
        }

        field(50206; GAPS; text[500])
        {
            DataClassification = CustomerContent;
        }

        field(50207; ClinicalClerkshipRemediation; text[500])
        {
            DataClassification = CustomerContent;
            Caption = 'ClinicalClerkshipRemediation';
        }


        field(60000; "Application Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count(MSPE where("Student No" = Field("Student No"), "Application Type" = Field("Application Type")));
            Editable = false;
        }




    }

    keys
    {
        key(PK; "Application No")
        {
            Clustered = true;
        }
    }
    trigger OnInsert()
    begin

        "Creation On" := Today();
        "Created By" := Userid();
        "Modified On" := TODAY();
        "Modified By" := FORMAT(UserId());

        Inserted := true;
        //InsertGraduateAffairs(Rec);
    end;

    trigger OnModify()
    begin
        "Modified On" := TODAY();
        "Modified By" := FORMAT(UserId());
        IF "Created By" = '' then
            "Created By" := FORMAT(UserId());
        IF "Processing Status" = "Processing Status"::Completed then
            "Completed Date" := Today();

        If xRec.Updated = Updated then
            Updated := true;
    end;

    var
        StudentMasterRec: Record "Student Master-CS";


    // procedure SendEmail(StudentMasterRec: Record "Student Master-CS"; MSPERec: Record MSPE)
    // Var
    //     SMTPSetup_lRec: Record "Email Account";
    //     AcademicsSetup_lRec: Record "Academics Setup-CS";
    //     SMTP_lCU: Codeunit "Email Message";
    //     Subject_lTxt: Text;
    //     Body_lTxt: Text;
    //     EmailId_lTxt: Text;
    //     Recipients: List of [Text];
    // begin
    //     SMTPSetup_lRec.Reset();
    //     AcademicsSetup_lRec.Reset();
    //     Clear(Recipients);
    //     EmailId_lTxt := '';
    //     Clear(SMTP_lCU);

    //     SMTPSetup_lRec.Get();
    //     AcademicsSetup_lRec.Get();
    //     StudentMasterRec.TestField("E-Mail Address");

    //     EmailId_lTxt := StudentMasterRec."E-Mail Address";
    //     Recipients := EmailId_lTxt.Split(';');

    //     Subject_lTxt := '';
    //     Body_lTxt := '';

    //     Subject_lTxt := MSPERec."Application No" + ' : MSPE Application Status "' + Format(MSPERec."Processing Status") + '"';

    //     SMTP_lCU.Create('MEA', SMTPSetup_lRec."User ID", Recipients, Subject_lTxt, '', true);
    //     SMTP_lCU.AppendtoBody('Dear ' + StudentMasterRec."Student Name");
    //     SMTP_lCU.AppendtoBody('<br><br>');
    //     SMTP_lCU.AppendtoBody('This is to inform you that the MSPE Application No. ' + MSPERec."Application No" + ' submitted by you has been completed. Please review your MSPE, which will be forwarded via a separate e-mail from the GA team and review the application on your SLcM student portal on MSPE Application page. Include any comments /suggestions if you find any inaccurate information or typos or “no changes needed” and mark the status as “Review Required”.');
    //     SMTP_lCU.AppendtoBody('<br><br>');
    //     SMTP_lCU.AppendtoBody('You may also track status updates under "MSPE Application Status" page on your student portal.');
    //     SMTP_lCU.AppendtoBody('<br><br>');
    //     SMTP_lCU.AppendtoBody('For any clarifications, please comtact Graduate Affairs team at jferron@auamed.org or call on 212-661-8899 x 161');
    //     SMTP_lCU.AppendtoBody('<br><br>');
    //     SMTP_lCU.AppendtoBody('Regards');
    //     SMTP_lCU.AppendtoBody('<br><br>');
    //     SMTP_lCU.AppendtoBody('Graduate Affairs Team');
    //     SMTP_lCU.AppendtoBody('<br><br>');
    //     SMTP_lCU.AppendtoBody('THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL');
    //     //SMTP_lCU.Send();
    // end;

    // procedure SendEmailReviewCompleted(StudentNo: Code[20])
    // var
    //     SmtpMailRec: Record "Email Account";
    //     Studentmaster: Record "Student Master-CS";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     WebServicesFunctionsCod: Codeunit WebServicesFunctionsCSL;
    //     BodyText: text[2048];
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];

    // begin
    //     SmtpMailRec.Get();
    //     Studentmaster.GET(StudentNo);
    //     Studentmaster.TESTFIELD(Studentmaster."E-Mail Address");
    //     Recipient := Studentmaster."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";
    //     Subject := "Application No" + ' ' + ' Your MSPE Application is Completed!';

    //     SmtpMail.Create(SenderName, SenderAddress, Recipients, Subject, '');

    //     SmtpMail.AppendtoBody('Dear' + ' ' + Studentmaster."Student Name" + ',');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Your MSPE has been completed and will be forwarded shortly.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('For any further information, please contact Graduate Affairs team at jferron@auamed.org or contact at 212-661-8899 x 161.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Graduate Affairs Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('[THIS IS AN AUTOMATED MESSAGE – PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL]');
    //     BodyText := SmtpMail.GetBody();
    //     //Mail_lCU.Send();

    //     WebServicesFunctionsCod.ApiPortalinsertupdatesendNotification('MSPE Review Compeleted', 'MEA', SenderAddress, Format(Studentmaster."Student Name"),
    //     "Student No", Subject, BodyText, 'MSPE Review', 'MSPE', Format("Application No"), Format("Application Date", 0, 9),
    //     Recipient, 1, Studentmaster."Mobile Number", '', 1);
    // end;

    // procedure MSPERepeatApplicationMail(StudentMasterRec: Record "Student Master-CS"; MSPERec: Record MSPE)
    // var
    //     SmtpMailRec: Record "Email Account";
    //     SMTPMail: codeunit "Email Message";
    //     Mail_lCU: Codeunit Mail;
    //     SenderName: Text[100];
    //     SenderAddress: Text[250];
    //     Subject: Text[100];
    //     Recipients: List of [Text];
    //     Recipient: Text[100];
    // Begin
    //     SmtpMailRec.Get();
    //     StudentMasterRec.TESTFIELD("E-Mail Address");
    //     Recipient := StudentMasterRec."E-Mail Address";
    //     Recipients := Recipient.Split(';');
    //     SenderName := 'MEA';
    //     SenderAddress := SmtpMailRec."Email Address";

    //     Subject := "Application No" + ' ' + ' Your MSPE Application is Completed!';

    //     SmtpMail.Create('MEA', SenderAddress, Recipients, Subject, '');
    //     SmtpMail.AppendtoBody('Dear ' + StudentMasterRec."Student Name");
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Your MSPE has been completed and will be forwarded shortly.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('For any further information please contact Graduate Affairs team at jferron@auamed.org or contact at 212-661-8899 x 161.');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Regards');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('Graduate Affairs Team');
    //     SmtpMail.AppendtoBody('<br><br>');
    //     SmtpMail.AppendtoBody('THIS IS AN AUTOMATED MESSAGE - PLEASE DO NOT REPLY DIRECTLY TO THIS EMAIL');
    //     //Mail_lCU.Send();

    // End;

}