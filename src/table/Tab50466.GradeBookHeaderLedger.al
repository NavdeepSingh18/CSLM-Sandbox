table 50466 "Grade Book Header Ledger"
{
    DataClassification = CustomerContent;
    // LookupPageId = GradeBookHeaderLedgerList;
    // DrillDownPageId = GradeBookHeaderLedgerList;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(3; Course; Code[20])
        {
            Caption = 'Course';
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS";
        }
        field(4; Semester; Code[10])
        {
            Caption = 'Semester';
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS";
        }
        field(5; "Academic year"; Code[20])
        {
            Caption = 'Academic year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(6; "Term"; Option)
        {
            Caption = 'Term';
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
        }
        field(7; Status; Option)
        {
            OptionMembers = Open,"Pending For Approval",Approved,Rejected,Published;
            DataClassification = CustomerContent;
            trigger OnValidate()
            var
                GradeBook: Record "Grade Book";
            begin
                GradeBook.Reset();
                GradeBook.SetRange("Grade Book No.", "Document No.");
                if GradeBook.FindSet() then
                    GradeBook.ModifyAll(Status, Rec.Status);
            end;
        }

        field(33; "Created By"; Code[50])
        {
            Caption = 'Created By"';
            DataClassification = CustomerContent;
        }
        field(34; "Created On"; Date)
        {
            Caption = 'Created On';
            DataClassification = CustomerContent;
        }
        field(35; "Updated By"; Code[50])
        {
            Caption = 'Updated By';
            DataClassification = CustomerContent;
        }
        field(36; "Updated On"; Date)
        {
            Caption = 'Updated On';
            DataClassification = CustomerContent;
        }
        field(41; "To Be Approved By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'To Be Approved/Rejected By';
        }
        field(42; "Approved By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Approved/Rejected By';
        }
        field(43; "Approved On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Approved/Rejected By';
        }
        field(44; "Rejected Reason"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(45; "Rejected Reason Description"; text[2048])
        {
            DataClassification = CustomerContent;
        }
        field(46; "Send for Approval By"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Send for Approval By';
        }
        field(47; "Send for Approval On"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Send for Approval By';
        }
        field(48; "Send for Approval Time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(49; "Published By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(50; "Published On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(51; "Published Time"; Time)
        {
            DataClassification = CustomerContent;
        }
        field(60044; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(60045; "Entry Time"; Time)
        {
            DataClassification = CustomerContent;
        }


    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }


    }
    trigger OnDelete()
    begin
        Error('Ledger cannot be deleted');
    end;


}