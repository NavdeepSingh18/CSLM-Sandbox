table 50505 RoleCenterCueBackOffice
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Pending Purchase Quotes"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Quote), Status = filter("Pending Approval"), "Shortcut Dimension 1 Code" = field("Institute Code")));
        }
        field(3; "Pending Purchase Orders"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Order), Status = filter("Pending Approval"), "Shortcut Dimension 1 Code" = field("Institute Code")));
        }
        field(4; "Pending Purchase Invoice"; integer)
        {
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST(Invoice), Status = filter("Pending Approval"), "Shortcut Dimension 1 Code" = field("Institute Code")));
        }
        field(5; "Request to Approve-Purchasing"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count("Approval Entry" where("Table ID" = Filter(38), Status = Filter(Open), "Approver ID" = field("User ID Filter")));
        }
        field(6; "Trnfr. Ord.-Shd. but not Rec."; integer)
        {
            Caption = 'Transfer Order-Shipped but not Receive';
            FieldClass = FlowField;
            CalcFormula = count("Transfer Header" where("Completely Shipped" = Const(true), "Completely Received" = const(false), "Shortcut Dimension 1 Code" = field("Institute Code")));
        }
        field(7; "Pending Purchase Cr. Memo"; Integer)
        {
            Caption = 'Pending Purchase Credit Memo';
            FieldClass = FlowField;
            CalcFormula = Count("Purchase Header" WHERE("Document Type" = CONST("Credit Memo"), Status = filter("Pending Approval"), "Shortcut Dimension 1 Code" = field("Institute Code")));
        }
        field(8; "Hospital wise Inv. not Updated"; Integer)
        {
            Caption = 'Hospital wise Invoices not Updated';
            FieldClass = FlowField;
            CalcFormula = count("Roster Ledger Entry" where("Invoice No." = filter(''), "Invoice Date" = Filter('')));
        }
        Field(9; "Hospitalwise Check No not Upd"; Integer)
        {
            Caption = 'Hospital wise Check No. not Updated';
            FieldClass = Flowfield;
            CalcFormula = count("Roster Ledger Entry" where("Check No." = filter(''), "Check Date" = filter('')));
        }
        field(10; "Institute Code"; Code[20])
        {
            Caption = 'Institute Code';
            CaptionClass = '1,1,1';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            FieldClass = FlowFilter;
        }
        field(11; "User ID Filter"; Code[50])
        {
            Caption = 'User ID';
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