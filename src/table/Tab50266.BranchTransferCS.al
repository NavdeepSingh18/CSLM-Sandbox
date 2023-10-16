table 50266 "Branch Transfer-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   08/01/2019       OnInsert()                                 Get Student Related Information Values
    // 02    CSPL-00114   08/01/2019       Transfer To Course - OnValidate()          Code added for Course Transfer Information
    // 03    CSPL-00114   08/01/2019       Transfer To Course - OnLookup()            Code added for Course Transfer Information

    Caption = 'Branch Transfer-CS';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";

            trigger OnValidate()
            begin
                //Code added for Student Related Information::CSPL-00114::08012019: Start
                BranchTransferCS.Reset();
                BranchTransferCS.SETRANGE(BranchTransferCS."No.", "No.");
                IF BranchTransferCS.FINDLAST() THEN
                    LineNum := BranchTransferCS."Line No" + 1000
                ELSE
                    LineNum := 1000;

                "Line No" := LineNum;
                "Transfer Date" := TODAY();
                IF StudentMasterCS.GET("No.") THEN BEGIN
                    "Course Code" := StudentMasterCS."Course Code";
                    Semester := StudentMasterCS.Semester;
                    Section := StudentMasterCS.Section;
                    College := StudentMasterCS."Global Dimension 1 Code";
                    "Student Name" := StudentMasterCS."Student Name";
                    "Date of Birth" := StudentMasterCS."Date of Birth";
                    "Academic Year" := StudentMasterCS."Academic Year";
                    "Enrollment No." := StudentMasterCS."Enrollment No.";
                    "Application No." := StudentMasterCS."Application No.";
                    "Enquiry No." := StudentMasterCS."Enquiry No.";
                    "Global Dimension 1 Code" := StudentMasterCS."Global Dimension 1 Code";
                    "Global Dimension 2 Code" := StudentMasterCS."Global Dimension 2 Code";
                    "Type Of Course" := StudentMasterCS."Type Of Course";
                    Year := StudentMasterCS.Year;
                    "Old Category" := StudentMasterCS."Fee Classification Code";
                    "Old Sub-Category" := StudentMasterCS.Category;
                    "Admitted Year" := StudentMasterCS."Admitted Year";
                END;

                BranchInformationStudCS.Reset();
                BranchInformationStudCS.SETRANGE("Student No.", "No.");
                IF BranchInformationStudCS.FINDFIRST() THEN
                    "Transfer To Course" := BranchInformationStudCS."New Course Code";

                //Code added for Student Related Information::CSPL-00114::08012019: End
            end;
        }
        field(2; "Line No"; Integer)
        {
            Caption = 'Line No';
            DataClassification = CustomerContent;

        }
        field(3; "Course Code"; Code[20])
        {
            Caption = 'Course Code';
            DataClassification = CustomerContent;

            TableRelation = "Course Master-CS";
        }
        field(4; "Transfer To Course"; Code[20])
        {
            Caption = 'Transfer To Course';
            DataClassification = CustomerContent;


            trigger OnLookup()
            begin
                //Code added for Course Transfer Information::CSPL-00114::08012019: Start
                CourseMasterCS1.Reset();
                CourseMasterCS1.SETFILTER(Code, '<>%1', "Course Code");
                CourseMasterCS1.FINDSET();
                IF PAGE.RUNMODAL(0, CourseMasterCS1) = ACTION::LookupOK THEN BEGIN
                    "Transfer To Course" := CourseMasterCS1.Code;
                    IF CourseMasterCS.GET("Transfer To Course") THEN BEGIN
                        "Transfer To College" := CourseMasterCS."Global Dimension 1 Code";
                        "Transfer to Institute" := CourseMasterCS."Global Dimension 1 Code";
                        "Transfer to Department" := CourseMasterCS."Global Dimension 2 Code";
                    END ELSE BEGIN
                        "Transfer To College" := '';
                        "Transfer to Institute" := '';
                        "Transfer to Department" := '';
                    END;
                END;
                //Code added for Course Transfer Information::CSPL-00114::08012019: Start
            end;

            trigger OnValidate()
            var
            begin
                //Code added for Course Transfer Information::CSPL-00114::08012019: Start
                CourseMasterCS.Reset();
                CourseMasterCS.SETFILTER(Code, "Transfer To Course");
                IF CourseMasterCS.FINDSET() THEN BEGIN
                    "Transfer To College" := CourseMasterCS."Global Dimension 1 Code";
                    "Transfer to Institute" := CourseMasterCS."Global Dimension 1 Code";
                    "Transfer to Department" := CourseMasterCS."Global Dimension 2 Code";
                END;
                //Code added for Course Transfer Information::CSPL-00114::08012019: Start
            end;
        }
        field(5; "Transfer Date"; Date)
        {
            Caption = 'Transfer Date';
            DataClassification = CustomerContent;
        }
        field(50001; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50002; "Global Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50003; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            Editable = false;
            TableRelation = "Semester Master-CS";
        }
        field(50004; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            TableRelation = "Section Master-CS";
        }
        field(50005; Transfered; Boolean)
        {
            Caption = 'Transfered';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
        }
        field(50006; "Student Name"; Text[100])
        {
            Caption = 'Student Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
        }
        field(50007; "Date of Birth"; Date)
        {
            Caption = 'Date of Birth';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';

            trigger OnValidate()
            var

            begin
            end;
        }
        field(50008; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            TableRelation = "Academic Year Master-CS";
        }
        field(50009; "Enrollment No."; Code[20])
        {
            Caption = 'Enrollment No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
        }
        field(50010; "Admitted Year"; Code[20])
        {
            Caption = 'Admitted Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            Editable = false;
            TableRelation = "Academic Year Master-CS";
        }
        field(50011; "Application No."; Code[20])
        {
            Caption = 'Application No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            TableRelation = "Student Master-CS"."Application No." WHERE("Application No." = FIELD("Application No."));
        }
        field(50012; "Enquiry No."; Code[20])
        {
            Caption = 'Enquiry No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
        }
        field(50013; "Transfer To Section"; Code[10])
        {
            Caption = 'Transfer To Section';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            TableRelation = "Section Master-CS";
        }
        field(50014; "Transfer To Semester"; Code[10])
        {
            Caption = 'Transfer To Semester';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            Editable = false;
            TableRelation = "Semester Master-CS";
        }
        field(50015; College; Code[20])
        {
            Caption = 'College';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            Enabled = false;
        }
        field(50016; "Transfer To College"; Code[20])
        {
            Caption = 'Transfer To College';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50017; "Type Of Course"; Option)
        {
            Caption = 'Type Of Course';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            OptionCaption = ' ,Semester,Year';
            OptionMembers = " ",Semester,Year;
        }
        field(50018; Year; Code[20])
        {
            Caption = 'Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            TableRelation = "Year Master-CS";
        }
        field(50019; "Transfer To Year"; Code[10])
        {
            Caption = 'Transfer To Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            Editable = false;
            TableRelation = "Year Master-CS";
        }
        field(50020; "Created By"; Text[50])
        {
            Caption = 'Created By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
        }
        field(50021; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
        }
        field(50022; "Updated By"; Text[50])
        {
            Caption = 'Updated By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
        }
        field(50023; "Updated On"; Date)
        {
            Caption = 'Updated On';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
        }
        field(50024; "Updated By Name"; Text[50])
        {
            Caption = 'Updated By Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
        }
        field(50025; "Created By Name"; Text[50])
        {
            Caption = 'Created By Name';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
        }
        field(50026; Approved; Boolean)
        {
            Caption = 'Approved';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
        }
        field(50027; "Approved By"; Text[50])
        {
            Caption = 'Approved By';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
        }
        field(50028; "Old Category"; Code[20])
        {
            Caption = 'Old Category';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            Editable = false;
            TableRelation = "Fee Classification Master-CS".Code;
        }
        field(50029; "Transfer to Category"; Code[20])
        {
            Caption = 'Transfer To Category';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            TableRelation = "Fee Classification Master-CS".Code;
        }
        field(50030; "Transfer to Institute"; Code[20])
        {
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(50031; "Transfer to Department"; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50032; "Old Sub-Category"; Code[20])
        {
            Caption = 'Old Sub-Category';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            TableRelation = "Category Master-CS";
        }
        field(50033; "Transfer to Sub-Category"; Code[20])
        {
            Caption = 'Transfer to Sub-Category';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            TableRelation = "Category Master-CS";
        }
        field(50034; "Branch Transfered"; Boolean)
        {
            Caption = 'Branch Transfered';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
        }
        field(50035; "Transfer to Academic Year"; Code[20])
        {
            Caption = 'Transfer to Academic Year';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
            TableRelation = "Academic Year Master-CS";
        }
        field(50036; "New Enrollment No."; Code[20])
        {
            Caption = 'New Enrollment No.';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 08012019';
        }
    }

    keys
    {
        key(Key1; "No.", "Line No")
        {
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "No.", "Enrollment No.")
        {
        }
    }

    var
        StudentMasterCS: Record "Student Master-CS";
        BranchTransferCS: Record "Branch Transfer-CS";
        CourseMasterCS: Record "Course Master-CS";
        BranchInformationStudCS: Record "Branch Information Stud-CS";
        CourseMasterCS1: Record "Course Master-CS";
        LineNum: Integer;

}

