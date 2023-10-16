table 50502 RoleCenterCueHousing
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Total Housing"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Housing Master");
        }
        field(3; "Total Room"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Room Master");
            Caption = 'Total Apartment';
        }
        field(4; "Total Bed"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Room Wise Bed");
            Caption = 'Total Room';
        }
        field(5; "Total Available Room"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Room Master" where("Available Beds" = filter(> 0)));
            Caption = 'Total Available Apartment';
        }
        field(6; "Total Available Bed"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Room Wise Bed" where(Available = filter(true)));
            Caption = 'Total Available Room';
        }
        field(7; "Total Pending Housing Apps"; integer)
        {
            Caption = 'Total Pending Housing Applications';
            FieldClass = FlowField;
            CalcFormula = count("Housing Application" where(Status = filter("Pending for Approval")));//, "Academic Year" = field("Academic Year Filter")));
        }
        field(8; "Total Png Housing Waiver Apps"; integer)
        {
            Caption = 'Total Pending Waiver Applications';
            FieldClass = FlowField;
            CalcFormula = count("Opt Out" where(status = Filter("Pending for Approval"), "Application Type" = filter("Housing Wavier")));//, "Academic Year" = field("Academic Year Filter")));
        }
        field(9; "Total Pendg Housing Issue Apps"; integer)
        {
            Caption = 'Total Pending Housing Issue Applications';
            FieldClass = FlowField;
            CalcFormula = count("Housing Issue" where(Status = const("Pending for Approval")));
        }
        field(10; "Total Pndg Housing Change Apps"; integer)
        {
            Caption = 'Total Pending Housing Change Applications';
            FieldClass = FlowField;
            CalcFormula = count("Housing Change Request" where(Status = filter("Pending for Approval"), Type = filter("Change Request")));//, "Academic Year" = field("Academic Year Filter")));
        }
        field(11; "Total Pndg Housing Vacate Apps"; integer)
        {
            Caption = 'Total Pending Vacate Applications';
            FieldClass = FlowField;
            CalcFormula = count("Housing Change Request" where(Status = filter("Pending for Approval"), Type = filter(Vacate)));//, "Academic Year" = field("Academic Year Filter")));
        }
        field(12; "Total Png Housing Re-Regi."; integer)
        {
            Caption = 'Total Pending Housing Re-Registration Appliactions';
            FieldClass = FlowField;
            CalcFormula = count("Housing Change Request" where(Status = filter("Pending for Approval"), Type = filter("Re-Registration")));//, "Academic Year" = field("Academic Year Filter")));
        }
        field(13; "Total png Fin. acc. Apps"; integer)
        {
            Caption = 'Total Pending Financial Accountability Applications';
            FieldClass = FlowField;
            CalcFormula = count("Financial Accountability" where(Status = filter("Pending for Approval")));//, "Academic Year" = field("Academic Year Filter")));
        }
        field(14; "Total Png Parking Applications"; integer)
        {
            Caption = 'Total Pending Parking Applications';
            FieldClass = FlowField;
            CalcFormula = count("Housing Parking Details" where(Status = filter("Pending for Approval")));//, "Academic Year" = field("Academic Year Filter")));
        }
        field(15; "Total Pending Immigration Apps"; integer)
        {
            Caption = 'Total Pending Immigration Applications';
            FieldClass = FlowField;
            CalcFormula = count("Immigration Header" where("Document Status" = filter("Pending for Verification")));//, "Academic Year" = field("Academic Year Filter")));
        }
        field(18; "Housing Sign -off"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Student Master-CS" where("Academic Year" = field("Academic Year Filter"), "Housing Hold" = filter(true)));
        }
        field(16; "Global Dimension 1 Filter"; Code[20])
        {
            Caption = 'Institute Code';
            CaptionClass = '1,1,1';
            FieldClass = FlowFilter;
        }
        field(17; "Academic Year Filter"; Code[20])
        {
            FieldClass = FlowFilter;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}