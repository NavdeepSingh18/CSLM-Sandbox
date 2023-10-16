table 50532 "OLR Update Line"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;

        }
        field(2; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Student No."; code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Student Master-CS";
            trigger OnValidate()
            var
                StudentMaster_lRec: Record "Student Master-CS";
                OLRUpdateHeader_lRec: Record "OLR Update Header";
                OLRUpdateLine_lRec: Record "OLR Update Line";
            begin
                If "Student No." <> '' then begin

                    // OLRUpdateLine_lRec.Reset();
                    // OLRUpdateLine_lRec.SetRange("Student No.", Rec."Student No.");
                    // IF OLRUpdateLine_lRec.FindFirst() then
                    //     Error('Student No : %1 already exist.', Rec."Student No.");

                    OLRUpdateHeader_lRec.Reset();
                    OLRUpdateHeader_lRec.SetRange("No.", Rec."Document No.");
                    IF OLRUpdateHeader_lRec.FindFirst() then begin
                        StudentMaster_lRec.Reset();
                        StudentMaster_lRec.SetRange("No.", Rec."Student No.");
                        // StudentMaster_lRec.SetRange("Academic Year", OLRUpdateHeader_lRec."OLR Academic Year");
                        // StudentMaster_lRec.SetRange(Term, OLRUpdateHeader_lRec."OLR Term");
                        // StudentMaster_lRec.SetRange("Course Code", OLRUpdateHeader_lRec."Course Code");
                        // StudentMaster_lRec.SetRange("Global Dimension 1 Code", OLRUpdateHeader_lRec."Global Dimension 1 Code");
                        // StudentMaster_lRec.SetRange(Semester, OLRUpdateHeader_lRec.Semester);
                        // StudentMaster_lRec.SetRange("Returning Student", true);
                        // StudentMaster_lRec.SetRange(Status, 'REENTRY');
                        // IF Not StudentMaster_lRec.FindFirst() then
                        //     Error('Selected Student No : %1 must be exist for Next OLR details', Rec."Student No.");

                        IF StudentMaster_lRec.FindFirst() then begin
                            "Student Name" := StudentMaster_lRec."Student Name";
                            "Enrollment No." := StudentMaster_lRec."Enrollment No.";
                            "Original Student No." := StudentMaster_lRec."Original Student No.";
                            Status := StudentMaster_lRec.Status;
                            "Registrar Sign Off" := StudentMaster_lRec."Registrar Signoff";
                            "Academic Year" := StudentMaster_lRec."Academic Year";
                            Term := StudentMaster_lRec.Term;
                            "Global Dimension 1 Code" := StudentMaster_lRec."Global Dimension 1 Code";
                            "Course Code" := StudentMaster_lRec."Course Code";
                            Semester := StudentMaster_lRec.Semester;
                        end;
                        "OLR Academic Year" := OLRUpdateHeader_lRec."OLR Academic Year";
                        "OLR Semester" := OLRUpdateHeader_lRec."OLR Semester";
                        "OLR Term" := OLRUpdateHeader_lRec."OLR Term";
                        "OLR Start Date" := OLRUpdateHeader_lRec."OLR Start Date";
                        "OLR Status" := OLRUpdateHeader_lRec.Status;
                    end;

                end Else begin
                    "Student Name" := '';
                    "Enrollment No." := '';
                    "Original Student No." := '';
                    "Academic Year" := '';
                    "Course Code" := '';
                    Semester := '';
                    Status := '';
                    "OLR Academic Year" := '';
                    "OLR Semester" := '';
                    "OLR Start Date" := 0D;

                end;
            end;
        }
        field(4; "Student Name"; Text[100])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(5; "Enrollment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(6; "Original Student No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(7; Status; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(8; "Course Code"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Course Master-CS".Code where("Global Dimension 1 Code" = field("Global Dimension 1 Code"));
            //Editable = false;
        }
        field(9; "Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
            //Editable = false;
        }
        field(10; Term; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            //Editable = false;
        }
        field(11; "Global Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            //Editable = false;
        }
        field(12; Semester; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Semester Master-CS".Code where("Global Dimension 1 Code" = field("Global Dimension 1 Code"), "OLR Applicable" = const(true));
            //Editable = false;
        }
        field(13; "Registrar Sign Off"; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(14; "OLR Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(15; "OLR Academic Year"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(16; "OLR Semester"; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(17; "OLR Term"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'FALL,SPRING,SUMMER';
            OptionMembers = FALL,SPRING,SUMMER;
            Editable = false;
        }
        field(18; Confirmed; Boolean)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(19; Select; Boolean)
        {
            DataClassification = CustomerContent;

        }

        field(20; "OLR Status"; Option)
        {
            DataClassification = CustomerContent;
            OptionCaption = 'Open,Released';
            OptionMembers = "Open","Released";
            Editable = false;
        }
        field(21; "Ready to Confirm"; Boolean)
        {
            DataClassification = CustomerContent;
        }

        field(22; "Process Date Time"; DateTime)
        {
            DataClassification = CustomerContent;
        }
        Field(23; "Student Master Sync"; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(24; "OLR Completed"; Boolean)
        {
            FieldClass = FlowField;
            CalcFormula = lookup("Student Master-CS"."OLR Completed" where("No." = Field("Student No.")));
            Editable = False;
        }
        field(25; "Current Student Status"; Code[20])
        {
            FieldClass = Flowfield;
            CalcFormula = lookup("Student Master-CS".Status where("No." = field("Student No.")));
            Editable = false;
        }
        field(26; Reminder; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(27; "Reminder No."; Integer)
        {
            DataClassification = CustomerContent;
            Editable = False;
        }
        field(28; "Insert By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(29; "Insert On"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(30; "Modified By"; Code[50])
        {
            DataClassification = CustomerContent;
        }
        field(31; "Modified On"; Date)
        {
            DataClassification = CustomerContent;
        }


    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Insert By" := userid();
        "Insert On" := today();
    end;

    trigger OnModify()
    begin
        "Modified By" := userid();
        "Modified On" := Today();

    end;

    trigger OnDelete()
    begin
        If Rec.Confirmed then
            TestField("OLR Status", "OLR Status"::Open);
    end;

    trigger OnRename()
    begin

    end;

    procedure Setstyle(): Text[100]
    begin
        IF Confirmed then
            exit('Strong')
        Else
            Exit('');
    end;

}