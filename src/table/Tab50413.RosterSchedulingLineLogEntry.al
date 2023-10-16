table 50413 "Roster Schd. Line Log Entry"
{
    DataClassification = ToBeClassified;
    Caption = 'Roster Scheduling Line Log Entry';
    fields
    {
        field(1; "Rotation ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation ID';
        }
        field(2; "Academic Year"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Academic Year';
            TableRelation = "Academic Year Master-CS".Code;
        }
        field(3; "Semester"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Semester';
            TableRelation = "Semester Master-CS".Code;
            Editable = false;
        }
        field(4; "Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Student No.';
            TableRelation = "Student Master-CS"."No.";
        }
        field(5; "First Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'First Name';
            Editable = false;
        }
        field(6; "Middle Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Middle Name';
            Editable = false;
        }
        field(7; "Last Name"; Text[35])
        {
            DataClassification = CustomerContent;
            Caption = 'Last Name';
            Editable = false;
        }
        field(8; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Student Name';
            Editable = false;
        }
        field(9; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Enrollment No.';
            Editable = false;
        }
        field(10; "Entry Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry Type';
            OptionMembers = Clerkship,"FM-1_IM-1";
        }

        field(11; "Clerkship Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Clerkship Type';
            OptionMembers = " ","Core","Elective";
        }
        field(12; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Code';
            TableRelation = if ("Course Type" = filter(Core)) "Subject Master-CS".Code where("Type of Subject" = filter(Core), "Subject Classification" = const('INDUSTRAINING'))
            else
            "Subject Master-CS".Code;
        }
        field(17; "Course Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Course Description';
        }
        field(18; "Elective Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Elective Course Code';
        }
        field(19; "Rotation Description"; Text[200])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Description';
        }

        field(20; "Course Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Course Type';
            OptionMembers = " ","Core","Elective","FM1/IM1";
        }
        field(21; "No. of Weeks"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'No. of Weeks';
            Editable = false;

            trigger OnValidate()
            begin
                Validate("Estimated Rotation Cost");
            end;
        }

        field(22; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date';
            Editable = false;
        }

        field(23; "End Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'End Date';
            Editable = false;
        }

        field(24; "Hospital ID"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital ID';
            TableRelation = Vendor."No." where("Vendor Sub Type" = filter(Hospital));
        }
        field(25; "Hospital Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Hospital Name';
            Editable = false;
        }
        field(26; "Clinical Cordinator ID"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Clinical Cordinator ID';
            TableRelation = "User Setup"."User ID";
        }
        field(27; "Document Specialist ID"; Text[80])
        {
            DataClassification = CustomerContent;
            Caption = 'Document Specialist ID';
            TableRelation = "User Setup"."User ID";
        }
        field(28; "Global Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(29; "Global Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(30; "Total No. of Seats"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Total No. of Seats';
            DecimalPlaces = 0;
            Editable = false;
        }
        field(31; "Student Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","Scheduled","Confirmed","Unconfirmed","In-Progress","Completed";
            Editable = false;
        }
        field(32; "Estimated Rotation Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Estimated Rotation Cost';
            Editable = false;

            trigger OnValidate()
            begin
                "Total Estimated Rotation Cost" := "Estimated Rotation Cost" * "Total No. of Seats" * "No. of Weeks";
            end;
        }
        field(33; "Total Estimated Rotation Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Estimated Rotation Cost';
            Editable = false;
        }
        field(34; "Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = "Scheduled","Published","Cancelled","Unconfirmed","Completed","In-Review","FM1/IM1 Confirmed","On Hold"; //CSPL-00307-RTP
        }
        field(35; "Published By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Published By';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(36; "Published On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Published On';
            Editable = false;
        }
        field(37; "Scheduled By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Scheduled By';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(38; "Scheduled On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Scheduled On';
            Editable = false;
        }
        field(39; "Cancelled By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancelled By';
            Editable = false;
            TableRelation = User."User Name";
        }
        field(40; "Cancelled Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Cancelled Date';
            Editable = false;
        }
        field(41; "Cancelled Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Cancelled Time';
            Editable = false;
        }

        field(42; "Student Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = " ","GHT Student","International Student";
            Caption = 'Student Type';
        }
        field(43; "Waitlisted"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Waitlisted';
        }
        field(44; "Rotation Confirmed"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Confirmed';
            Editable = false;
        }
        field(45; "Rotation Confirmed By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Confirmed By';
            Editable = false;
        }
        field(46; "Rotation Confirmed On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Rotation Confirmed On';
            Editable = false;
        }
        field(47; "Cancel Reason Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancellation Reason Code';
            TableRelation = "Reason Code".Code;
        }
        field(48; "Cancel Reason Description"; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Cancellation Reason Description';
        }
        field(49; "Offer No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Offer No.';
            Editable = false;
        }
        field(50; "Offer Application Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Offer Application Line No.';
            Editable = false;
        }
        field(51; "FM1/IM1 Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'FM1/IM1 Application No.';
            Editable = false;
        }
        field(52; "Non-Affiliated Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Non-Affiliated Application No.';
            Editable = false;
        }
        field(53; "Ledger Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Ledger Entry No.';
            Editable = false;
        }
        field(54; "Action of Student"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Action of Student';
            OptionMembers = " ",Pending,Confirmed,Rejected;
            Editable = false;
        }

        field(63; "CLOA Application No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'CLOA Application No.';
            Editable = false;
        }

        field(700; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Entry No.';
            Editable = false;
        }
        field(701; "Deleted By"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Deleted By';
            Editable = false;
        }
        field(702; "Deleted Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Deleted Date';
            Editable = false;
        }
        field(703; "Deleted Time"; Time)
        {
            DataClassification = CustomerContent;
            Caption = 'Deleted time';
            Editable = false;
        }
    }

    keys
    {
        key(PK; "Rotation ID", "Academic Year", "Student No.", "Entry No.")
        {
            Clustered = true;
        }
        key(SortListName; Semester, "Last Name", "Middle Name", "First Name")
        {
            Clustered = false;
        }
    }


    trigger OnDelete()
    begin
        Error('Delete not Allowed.');
    end;
}