table 50231 "Student Achievement-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                    Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   09/09/2019       Student No - OnValidate()               Get Student Related Information Values
    // 02    CSPL-00114   09/09/2019       ImportAttachment()                      Create Function for Import Attachment
    // 03    CSPL-00114   09/09/2019       OpenAttachment()                        Create Function for Open Attachment
    // 04    CSPL-00114   09/09/2019       ExportAttachment()                      Create Function for Export Attachment
    // 05    CSPL-00114   09/09/2019       RemoveAttachment()                      Create Function for Remove Attachment

    Caption = 'Student Achievement-CS';

    fields
    {
        field(1; "Student No"; Code[20])
        {
            TableRelation = "Student Master-CS"."No.";
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Get Student Related Information Values::CSPL-00114::09092019: Start
                StudentAchievementCS.Reset();
                StudentAchievementCS.SETRANGE(StudentAchievementCS."Student No", "Student No");
                IF StudentAchievementCS.FINDLAST() THEN
                    "Line No" := StudentAchievementCS."Line No" + 10000
                ELSE
                    "Line No" := 10000;

                StudentMasterCS.Reset();
                StudentMasterCS.SETRANGE(StudentMasterCS."No.", "Student No");
                IF StudentMasterCS.FindFirst() THEN BEGIN
                    "Student Name" := StudentMasterCS."Student Name";
                    Course := StudentMasterCS."Course Code";
                    Semester := StudentMasterCS."Semester";
                    Enrollment := StudentMasterCS."Enrollment No.";
                    "Academic Year" := StudentMasterCS."Academic Year";
                    "Roll No" := StudentMasterCS."Roll No.";
                END;

                Date := TODAY();
                "Created Date" := TODAY();
                //Get Student Related Information Values::CSPL-00114::09092019: End
            end;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No.';
            DataClassification = CustomerContent;
        }
        field(3; Enrollment; Code[20])
        {
            TableRelation = "Student Master-CS"."Enrollment No.";
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
        }
        field(4; "Roll No"; Code[20])
        {
            Caption = 'Roll No.';
            DataClassification = CustomerContent;
        }
        field(5; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
        }
        field(7; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
        }
        field(8; Date; Date)
        {
            Caption = 'Date';
            DataClassification = CustomerContent;
        }
        field(9; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;
        }
        field(11; Extension; Text[30])
        {
            Caption = 'Extension';
            DataClassification = CustomerContent;
        }
        field(12; "File Name"; Text[30])
        {
            Caption = 'File Name';
            DataClassification = CustomerContent;
        }
        field(13; Type; Option)
        {
            OptionCaption = ' ,Achievement,Incident';
            OptionMembers = " ",Achievement,Incident;
            Caption = 'Type';
            DataClassification = CustomerContent;
        }
        field(14; "Created By"; Text[30])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
        }
        field(15; "Created Date"; Date)
        {
            Caption = 'Created Date';
            DataClassification = CustomerContent;
        }
        field(16; "Updated By"; Text[30])
        {
            Caption = 'Updated By';
            DataClassification = CustomerContent;
        }
        field(17; "Updated Date"; Date)
        {
            Caption = 'Updated Date';
            DataClassification = CustomerContent;
        }
        field(18; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
        }
        field(19; "Attachment No."; Integer)
        {
            Caption = 'Attachment No.';
            DataClassification = CustomerContent;
        }
        field(20; Inserted; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Inserted';
        }
        field(21; Updated; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Updated';
        }
    }

    keys
    {
        key(Key1; "Student No", "Line No")
        {
        }
    }

    fieldgroups
    {
    }

    Trigger OnInsert()
    Begin
        Inserted := true;
    End;

    trigger OnModify()
    Begin
        If xRec.Updated = Updated then
            Updated := true;
    End;

    var
        StudentMasterCS: Record "Student Master-CS";
        StudentAchievementCS: Record "Student Achievement-CS";


    procedure ImportAttachment()
    var

    begin
        //Create Function for Import Attachment::CSPL-00114::09092019: Start
        //CS-BLOCKEDIF NewAttachment.ImportAttachmentFromClientFile('', FALSE, TRUE) THEN BEGIN
        //CS-BLOCKED"Attachment No." := NewAttachment."No.";
        //CS-BLOCKED"File Name" := NewAttachment."File Name";
        //CS-BLOCKEDModify();
        MESSAGE('Attachment Imported Successfully');
    END;
    //Create Function for import Attachment::CSPL-00114::09092019: End

    procedure OpenAttachment()
    var

        NewAttachment: Record "Attachment";
    begin
        //Create Function for Open Attachment::CSPL-00114::09092019: Start
        IF "Attachment No." = 0 THEN
            EXIT;

        NewAttachment.GET("Attachment No.");
        //CS-BLOCKEDNewAttachment.OpenAttachment("File Name", FALSE, '');

        //Create Function for Open Attachment::CSPL-00114::09092019: End
    end;

    procedure ExportAttachment()
    var
        Attachment: Record "Attachment";
        ExportToFile: Text[240];
    begin
        //Create Function for Export Attachment::CSPL-00114::09092019: Start
        ExportToFile := '';
        Attachment.GET("Attachment No.");
        //CS-BLOCKEDAttachment.ExportAttachmentToClientFile(ExportToFile);
        //Create Function for Export Attachment::CSPL-00114::09092019: End
    end;

    procedure RemoveAttachment(Prompt: Boolean)
    var
        Attachment: Record "Attachment";
    begin
        //Create Function for remove Attachment::CSPL-00114::09092019: Start
        Attachment.GET("Attachment No.");
        //CS-BLOCKEDIF Attachment.RemoveAttachment(Prompt) THEN BEGIN
        //CS-BLOCKED    "Attachment No." := 0;
        //CS-BLOCKED    Modify();
        //CS-BLOCKEDEND;
        //Create Function for remove Attachment::CSPL-00114::09092019: End
    end;
}