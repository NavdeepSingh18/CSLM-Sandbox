table 50263 "Indent H-CS"
{
    // version V.001-CS

    // Sr.No   Emp.ID      Date            Trigger                                     Remarks
    // -----------------------------------------------------------------------------------------------
    // 01    CSPL-00114   06/01/2019       OnInsert()                                 Get "No Series","Academic Year",Date & "User Id" Values
    // 02    CSPL-00114   06/01/2019       OnDelete()                                 Code added for Lines Deleted
    // 03    CSPL-00114   06/01/2019       No. - OnValidate()                         Code added for Status Related
    // 04    CSPL-00114   06/01/2019       Issue For - OnValidate()                   Code added for Lines Delete & Status & Issued Field Blank
    // 05    CSPL-00114   06/01/2019       Issue Date - OnValidate()                  Code added for Status Related
    // 06    CSPL-00114   06/01/2019       User Id - OnValidate()                     Code added for Status Related
    // 07    CSPL-00114   06/01/2019       Item No - OnValidate()                     Get Description & Status Related Code added
    // 08    CSPL-00114   06/01/2019       Description - OnValidate()                 Status Related Code added
    // 09    CSPL-00114   06/01/2019       Same Item - OnValidate()                   Get Description & Status Related Code added
    // 10    CSPL-00114   06/01/2019       Status - OnValidate()                      Status Related Code added
    // 11    CSPL-00114   06/01/2019       Issue Id - OnValidate()                    Issue Id,'Issue For' Related Code added
    // 12    CSPL-00114   06/01/2019       Issue Id - OnLookup()                      'Issue For',Issue Id Related Code added
    // 13    CSPL-00114   06/01/2019       Assistedit -Function                       Get "No Series" Code added
    // 14    CSPL-00114   06/01/2019       InsertIssueLineforDepartment -Function     Insert Issue Line for Department Code added
    // 15    CSPL-00114   06/01/2019       InsertIssueLineforEmployee -Function       Insert Issue Line for Employee Code added
    // 16    CSPL-00114   06/01/2019       InsertIssueLineforStudent -Function        Insert Issue Line for Student Code added

    Caption = 'Indent L-CS';

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Code added for Status Related ::CSPL-00114::06012019: Start
                IF Status = Status::"Processed for Approval" THEN
                    ERROR('Indent is already in process');
                //Code added for Status Related ::CSPL-00114::06012019: End
            end;
        }
        field(2; "Issue For"; Option)
        {
            Caption = 'Issue For';
            DataClassification = CustomerContent;
            OptionCaption = ' ,Department,Employee';
            OptionMembers = " ",Department,Employee;

            trigger OnValidate()
            begin
                //Code added for Lines Delete & Status & Issued Field Blank ::CSPL-00114::06012019: Start
                IF "Issue For" <> xRec."Issue For" THEN BEGIN
                    "Issue Id" := '';
                    "Issue Name" := '';
                END;

                IF "Issue For" = "Issue For"::" " THEN BEGIN
                    IndentLCS.Reset();
                    IndentLCS.SETRANGE("Document No", "No.");
                    IndentLCS.DELETEALL(TRUE);
                END;

                IF Status = Status::"Processed for Approval" THEN
                    ERROR('Indent is already in process');
                //Code added for Lines Delete & Status & Issued Field Blank ::CSPL-00114::06012019: End
            end;
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
        field(5; Section; Code[10])
        {
            Caption = 'Section';
            DataClassification = CustomerContent;
            TableRelation = "Section Master-CS";
        }
        field(6; "Academic Year"; Code[20])
        {
            Caption = 'Academic Year';
            DataClassification = CustomerContent;
            TableRelation = "Academic Year Master-CS";
        }
        field(7; "Issue Date"; Date)
        {
            Caption = 'Issue Date';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                //Code added for Status Related ::CSPL-00114::06012019: Start
                IF Status = Status::"Processed for Approval" THEN
                    ERROR('Indent is already in process');
                //Code added for Status Related ::CSPL-00114::06012019: End
            end;
        }
        field(8; "User ID"; Code[50])
        {
            Caption = 'User Id';
            DataClassification = CustomerContent;
            Editable = false;

            trigger OnValidate()
            begin
                //Code added for Status Related ::CSPL-00114::06012019: Start
                IF Status = Status::"Processed for Approval" THEN
                    ERROR('Indent is already in process');
                //Code added for Status Related ::CSPL-00114::06012019: End
            end;
        }
        field(9; "No. Series"; Code[20])
        {
            Caption = 'No. Series';
            DataClassification = CustomerContent;
        }
        field(10; "Item No"; Code[20])
        {
            Caption = 'Item No';
            DataClassification = CustomerContent;
            Editable = true;
            TableRelation = Item;

            trigger OnValidate()
            begin
                //Get Description & Status Related Code added ::CSPL-00114::06012019: Start
                IF GRecItemCS.GET("Item No") THEN
                    Description := GRecItemCS.Description;


                IF Status = Status::"Processed for Approval" THEN
                    ERROR('Indent is already in process');
                //Get Description & Status Related Code added ::CSPL-00114::06012019: End
            end;
        }
        field(11; Description; Text[100])
        {
            Caption = 'Description';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                //Status Related Code added ::CSPL-00114::06012019: Start
                IF Status = Status::"Processed for Approval" THEN
                    ERROR('Indent is already in process');
                //Status Related Code added ::CSPL-00114::06012019: End
            end;
        }
        field(12; "Same Item"; Boolean)
        {
            Caption = 'Same Item';
            DataClassification = CustomerContent;
            trigger OnValidate()
            begin
                //Get Description & Status Related Code added ::CSPL-00114::06012019: Start
                IF "Same Item" = FALSE THEN BEGIN
                    CLEAR("Item No");
                    CLEAR(Description)
                END;

                IF Status = Status::"Processed for Approval" THEN
                    ERROR('Indent is already in process');
                //Get Description & Status Related Code added ::CSPL-00114::06012019: End
            end;
        }
        field(13; Status; Option)
        {
            Caption = 'Status';
            DataClassification = CustomerContent;
            Editable = false;
            OptionCaption = 'Open,Processed for Approval,Approved,Released,Rejected';
            OptionMembers = Open,"Processed for Approval",Approved,Released,Rejected;

            trigger OnValidate()
            begin
                //Status Related Code added ::CSPL-00114::06012019: Start
                IF Status = Status::"Processed for Approval" THEN
                    ERROR('Indent is already in process');
                //Status Related Code added ::CSPL-00114::06012019: End
            end;
        }
        field(14; "Issued All"; Boolean)
        {
            Caption = 'Issued All';
            DataClassification = CustomerContent;
        }
        field(15; "Issue Id"; Code[20])
        {
            Caption = 'Issue Id';
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin

                //'Issue For',Issue Id Related Code added ::CSPL-00114::06012019: Start
                CASE "Issue For" OF
                    "Issue For"::Department:
                        BEGIN
                            GrecDimValueCS.Reset();
                            GrecDimValueCS.SETFILTER("Dimension Code", 'DEPARTMENT');
                            IF PAGE.RUNMODAL(537, GrecDimValueCS) = ACTION::LookupOK THEN
                                VALIDATE("Issue Id", GrecDimValueCS.Code);
                        END;
                    "Issue For"::Employee:
                        BEGIN
                            GRecEmpCS.Reset();
                            IF PAGE.RUNMODAL(5201, GRecEmpCS) = ACTION::LookupOK THEN
                                VALIDATE("Issue Id", GRecEmpCS."No.");
                        END;
                END;
                IF "Issue Id" <> xRec."Issue Id" THEN BEGIN
                    IndentLCS.Reset();
                    IndentLCS.SETRANGE("Document No", "No.");
                    IF IndentLCS.FindSet() THEN
                        REPEAT
                            IndentLCS."No." := "Issue Id";
                            IndentLCS.Name := "Issue Name";
                        UNTIL IndentLCS.NEXT() = 0;
                END;
                //'Issue For',Issue Id Related Code added ::CSPL-00114::06012019: End
            end;

            trigger OnValidate()
            begin
                //Issue Id,'Issue For' Related Code added ::CSPL-00114::06012019: Start
                IF "Issue Id" <> xRec."Issue Id" THEN
                    "Issue Name" := '';
                IF "Issue Id" = '' THEN BEGIN
                    "Issue Name" := '';
                    EXIT;
                END;
                CASE "Issue For" OF
                    "Issue For"::Department:
                        BEGIN
                            GrecDimValueCS.GET('DEPARTMENT', "Issue Id");
                            "Issue Name" := GrecDimValueCS.Name;

                        END;
                    "Issue For"::Employee:
                        BEGIN
                            GRecEmpCS.GET("Issue Id");
                            "Issue Name" := FORMAT(GRecEmpCS."First Name" + '' + GRecEmpCS."Middle Name" + '' + GRecEmpCS."Last Name");
                        END;
                END;
                //Issue Id,'Issue For' Related Code added ::CSPL-00114::06012019: End
            end;
        }
        field(16; "Issue Name"; Text[50])
        {
            Caption = 'Issue Name';
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50000; "Posted Indent"; Boolean)
        {
            Caption = 'Posted Indent';
            DataClassification = CustomerContent;
            Description = 'CS Field Added 06012019';
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "No.")
        {
        }
    }

    fieldgroups
    {
    }

    trigger OnDelete()
    begin
        //Code added for Lines Deleted::CSPL-00114::06012019: Start
        IndentLCS.Reset();
        IndentLCS.SETRANGE("Document No", "No.");
        IndentLCS.DELETEALL(TRUE);
        //Code added for Lines Deleted::CSPL-00114::06012019: End
    end;

    trigger OnInsert()
    begin
        //Code added for "No Series","Academic Year",Date & "User Id" Values::CSPL-00114::06012019: Start
        PurchasesPayablesSetup.GET();
        IF "No. Series" = '' THEN BEGIN
            PurchasesPayablesSetup.TESTFIELD("Indent No.");
            NoSeriesMgt.InitSeries(PurchasesPayablesSetup."Indent No.", xRec."No.", 0D, "No.", "No. Series");
        END;

        "Academic Year" := VerticalEducationCS.CreateSessionYear();
        "Issue Date" := WORKDATE();
        "User Id" := FORMAT(UserId());
        //Code added for "No Series","Academic Year",Date & "User Id" Values::CSPL-00114::06012019: End
    end;

    var
        PurchasesPayablesSetup: Record "Purchases & Payables Setup";

        IndentLCS: Record "Indent L-CS";
        GRecEmpCS: Record "Employee";
        GRecItemCS: Record "Item";

        GrecDimValueCS: Record "Dimension Value";
        NoSeriesMgt: Codeunit "NoSeriesManagement";
        VerticalEducationCS: Codeunit "CSLMVerticalEducation-CS";



    procedure Assistedit(IndentHCS1: Record "Indent H-CS"): Boolean
    begin
        //Get "No Series" Code added ::CSPL-00114::06012019: Start
        WITH IndentHCS1 DO BEGIN
            IndentHCS1 := Rec;
            PurchasesPayablesSetup.GET();
            PurchasesPayablesSetup.TESTFIELD("Indent No.");
            IF NoSeriesMgt.SelectSeries(PurchasesPayablesSetup."Indent No.", "No. Series", "No. Series") THEN BEGIN
                NoSeriesMgt.SetSeries("No.");
                Rec := IndentHCS1;
                EXIT(TRUE);
            END;
        END;
        //Get "No Series" Code added ::CSPL-00114::06012019: End
    end;

    procedure "Insert Issue Line for Department"(LVar_IssNo: Code[20]; LVar_Date: Date; LVar_DeptNo: Code[20]; LVar_DeptName: Text[50]; LVar_ItemNo: Code[20]; LVar_ItmName: Text[50]; LVar_Qty: Decimal)
    begin
        /*
        //Insert Issue Line for Department Code added ::CSPL-00114::06012019: Start
        IndentLCS."Document No" := LVar_IssNo;
        IndentLCS."Issue Date" := LVar_Date;
        IndentLCS."Indent For" := IndentLCS."Indent For"::Department;
        IndentLCS."Line No." += 10000;
        IndentLCS."Serial No" += 1;
        IndentLCS."No." := LVar_DeptNo;
        IndentLCS.Name := LVar_DeptName;
        IndentLCS."Item No" := LVar_ItemNo;
        IndentLCS.VALIDATE("Item No");
        IndentLCS."Unit Price" := LVar_Qty;
        IndentLCS.INSERT();
        //Insert Issue Line for Department Code added ::CSPL-00114::06012019: End
        */

    end;

    procedure "Insert Issue Line for Employee"(LVar_IssNo: Code[20]; LVar_Date: Date; LVar_EmpNo: Code[20]; LVar_EmpName: Text[50]; LVar_ItemNo: Code[20]; LVar_ItmName: Text[50]; LVar_Qty: Decimal)
    begin
        /*
        //Insert Issue Line for Employee Code added ::CSPL-00114::06012019: Start
        IndentLCS."Document No" := LVar_IssNo;
        IndentLCS."Issue Date" := LVar_Date;
        IndentLCS."Indent For" := IndentLCS."Indent For"::Employee;
        IndentLCS."Line No." += 10000;
        IndentLCS."Serial No" += 1;
        IndentLCS."No." := LVar_EmpNo;
        IndentLCS.Name := LVar_EmpName;
        IndentLCS."Item No" := LVar_ItemNo;
        IndentLCS.VALIDATE("Item No");
        IndentLCS."Unit Price" := LVar_Qty;
        IndentLCS.INSERT();
        //Insert Issue Line for Employee Code added ::CSPL-00114::06012019: End
        */

    end;

    procedure "Insert Issue Line for Student"(LVar_IssNo: Code[20]; LVar_Date: Date; LVar_StdNo: Code[20]; LVar_StdName: Text[50]; LVar_ItemNo: Code[20]; LVar_ItmName: Text[50]; LVar_Qty: Decimal)
    begin
        /*
        //Insert Issue Line for Student Code added ::CSPL-00114::06012019: Start
        IndentLCS."Document No" := LVar_IssNo;
        IndentLCS."Issue Date" := LVar_Date;
        IndentLCS."Indent For" := IndentLCS."Indent For"::Student;
        IndentLCS."Line No." += 10000;
        IndentLCS."Serial No" += 1;
        IndentLCS."No.":= LVar_StdNo;
        IndentLCS.Name :=LVar_StdName;
        IndentLCS."Item No" := LVar_ItemNo;
        IndentLCS.VALIDATE("Item No");
        IndentLCS."Unit Price" := LVar_Qty;
        IndentLCS.VALIDATE(Quantity);
        IndentLCS.INSERT();
        //Insert Issue Line for Student Code added ::CSPL-00114::06012019: End
        */

    end;
}

