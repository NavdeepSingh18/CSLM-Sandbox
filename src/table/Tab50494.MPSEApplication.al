table 50494 "MPSE Application"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Application No"; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(2; "Application Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Application Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ",New,Repeat;
        }
        field(4; "Student No."; Code[20])
        {
            Caption = 'Student No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";

            trigger OnValidate()
            Var
                StudentMasterCS: Record "Student Master-CS";
            begin
                IF StudentMasterCS.GET("Student No.") THEN
                    "Student Name" := StudentMasterCS."Student Name";
            end;
        }
        field(5; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Editable = False;
        }

        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS";
            DataClassification = CustomerContent;
        }
        field(7; Semester; Code[10])
        {
            Caption = 'Semester';
            Editable = false;
            TableRelation = "Semester Master-CS";
            DataClassification = CustomerContent;
        }
        field(8; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }

        field(9; "Step 1 Agree"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Last Name"; Text[35])
        {
            DataClassification = CustomerContent;
        }
        field(11; "First Name"; Text[35])
        {
            DataClassification = CustomerContent;
        }

        field(12; "Previous Last Name"; Text[35])
        {
            DataClassification = CustomerContent;
        }
        field(13; "Previous First Name"; Text[35])
        {
            DataClassification = CustomerContent;
        }

        field(14; "Phone Numbers"; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(15; "Mobile_Cell"; Text[30])
        {
            DataClassification = CustomerContent;
        }

        field(16; "Address"; Text[100])
        {
            DataClassification = CustomerContent;
        }

        field(17; "Country Code"; Code[10])
        {
            Caption = 'Country Code';
            TableRelation = "Country/Region";
            DataClassification = CustomerContent;
        }
        field(18; State; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(19; City; Text[30])
        {
            DataClassification = CustomerContent;
        }
        field(20; Zip; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(21; ERAS; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(22; CaRMS; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(23; "Other Specialty"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(24; "Other Specialty Description"; Text[100])
        {
            DataClassification = CustomerContent;
        }
        field(25; "1st Noteworthy Char. Exp."; Text[500])
        {
            caption = '1st Noteworthy Characteristics Exp.';
            DataClassification = CustomerContent;
        }
        field(26; "1st Noteworthy Char. Dates"; Code[20])
        {
            Caption = '1st Noteworthy Characteristics Dates';
            DataClassification = CustomerContent;
        }
        field(27; "1st Noteworthy Char. Location"; Text[100])
        {
            caption = '1st Noteworthy Characteristics Location';
            DataClassification = CustomerContent;
        }
        field(28; "2nd Noteworthy Char. Exp."; Text[500])
        {
            caption = '2nd Noteworthy Characteristics Exp.';
            DataClassification = CustomerContent;
        }
        field(29; "2nd Noteworthy Char. Dates"; Code[20])
        {
            caption = '2nd Noteworthy Characteristics Dates';
            DataClassification = CustomerContent;
        }
        field(30; "2nd Noteworthy Char. Location"; Text[100])
        {
            caption = '2nd Noteworthy Characteristics Location';
            DataClassification = CustomerContent;
        }
        field(31; "3rd Noteworthy Char. Exp."; Text[500])
        {
            caption = '3rd Noteworthy Characteristics Exp.';
            DataClassification = CustomerContent;
        }
        field(32; "3rd Noteworthy Char. Dates"; Code[20])
        {
            caption = '3rd Noteworthy Characteristics Dates';
            DataClassification = CustomerContent;
        }
        field(33; "3rd Noteworthy Char. Location"; Text[100])
        {
            caption = '3rd Noteworthy Characteristics Location';
            DataClassification = CustomerContent;
        }
        field(34; "4th Noteworthy Char. Exp."; Text[500])
        {
            caption = '4th Noteworthy Characteristics Exp.';
            DataClassification = CustomerContent;
        }
        field(35; "4th Noteworthy Char. Dates"; Code[20])
        {
            caption = '4th Noteworthy Characteristics Dates';
            DataClassification = CustomerContent;
        }
        field(36; "4th Noteworthy Char. Location"; Text[100])
        {
            caption = '4th Noteworthy Characteristics Location';
            DataClassification = CustomerContent;
        }
        field(37; "5th Noteworthy Char. Exp."; Text[500])
        {
            caption = '5th Noteworthy Characteristics Exp.';
            DataClassification = CustomerContent;
        }
        field(38; "5th Noteworthy Char. Dates"; Code[20])
        {
            caption = '5th Noteworthy Characteristics Dates';
            DataClassification = CustomerContent;
        }
        field(39; "5th Noteworthy Char. Location"; Text[100])
        {
            caption = '5th Noteworthy Characteristics Location';
            DataClassification = CustomerContent;
        }
        field(40; "Under Graduate School Name"; Text[100])
        {
            caption = 'Under Graduate School Name';
            DataClassification = CustomerContent;
        }
        field(41; "Under Graduate Location"; Text[100])
        {
            caption = 'Under Graduate Location';
            DataClassification = CustomerContent;
        }
        field(42; "Under Graduate Month Year"; Code[20])
        {
            caption = 'Under Graduate Month Year';
            DataClassification = CustomerContent;
        }
        field(43; "Under Graduate Degree"; Text[50])
        {
            caption = 'Under Graduate Degree';
            DataClassification = CustomerContent;
        }
        field(44; "Under Graduate Degree Major"; Text[50])
        {
            caption = 'Under Graduate Degree Major';
            DataClassification = CustomerContent;
        }
        field(45; "Field of Study"; Text[100])
        {
            caption = 'Field of Study';
            DataClassification = CustomerContent;
        }
        field(46; "PG_Current Position_Department"; Text[100])
        {
            caption = 'Post Graduate_Current Position_Department';
            DataClassification = CustomerContent;
        }
        field(47; "PG_Current Hospital_Inst."; Text[100])
        {
            caption = 'Post Graduate_Current Hospital_Institution';
            DataClassification = CustomerContent;
        }
        field(48; "PG_Current City_State"; Text[100])
        {
            caption = 'Post Graduate_Current City_State';
            DataClassification = CustomerContent;
        }
        field(49; "Post Graduate_Current From"; Date)
        {
            caption = 'Post Graduate_Current From';
            DataClassification = CustomerContent;
        }
        field(50; "Post Graduate_Current To"; Date)
        {
            caption = 'Post Graduate_Current To';
            DataClassification = CustomerContent;
        }
        field(51; "Do Not Update MPSE"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(52; "Application Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "",Draft,Confirmed;
        }
        field(53; "Processing Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "",Pending,Approved,Rejected;
        }
        field(54; "Processed By"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Employee;
        }
        field(55; "Processing Date"; Date)
        {
            DataClassification = CustomerContent;
        }

        field(56; "Created By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(57; "Created On"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(58; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(59; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
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
        "Created By" := Format(UserId());
        "Created On" := WorkDate();
    end;

    trigger OnModify()
    begin
        "Modified By" := Format(UserId());
        "Modified On" := WorkDate();
    end;



}