tableextension 50583 "tableextension50583" extends "Purchase Line"
{
    // version NAVW19.00.00.46621,NAVIN9.00.00.46621-CS

    // Sr.No.    Emp. ID       Date          Trigger           Remarks
    // 1         CSPL-00136    30-04-2019    OnDelete       Code added for Requisition Line modify Select Field.
    // 2         CSPL-00307    12-10-21                     New Field Added 50007
    fields
    {
        field(50000; "Indent No"; Code[20])
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Indent No.';
            DataClassification = CustomerContent;
        }
        field(50001; "Indent Line No"; Integer)
        {
            Description = 'CS Field Added 02-05-2019';
            Caption = 'Indent Line No.';
            DataClassification = CustomerContent;
        }
        field(50002; "Requisition No."; Code[20])
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(50003; "Requisition Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }

        field(5004; "Quantity Bool"; Boolean)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        Field(50005; "Final Quotation"; Boolean)
        {
            DataClassification = CustomerContent;

            Trigger OnValidate()
            var
                RequisitionLineRec: Record "Requisition Line_";
            Begin
                TestField("Requisition No.");
                If "Final Quotation" then begin
                    RequisitionLineRec.Reset();
                    RequisitionLineRec.SetRange("Document No.", Rec."Requisition No.");
                    RequisitionLineRec.SetRange("Line No.", Rec."Requisition Line No.");
                    If RequisitionLineRec.FindFirst() then begin
                        RequisitionLineRec."PO No." := Rec."Document No.";
                        RequisitionLineRec.Modify();
                    end;
                end Else begin
                    RequisitionLineRec.Reset();
                    RequisitionLineRec.SetRange("Document No.", Rec."Requisition No.");
                    RequisitionLineRec.SetRange("Line No.", Rec."Requisition Line No.");
                    If RequisitionLineRec.FindFirst() then begin
                        RequisitionLineRec."PO No." := '';
                        RequisitionLineRec.Modify();
                    end;
                end;
            End;
        }
        field(50006; "Budget Code"; Code[20])
        {
            DataClassification = ToBeClassified;
            // TableRelation = "Item Budget Name";
        }
        field(50007; "Requisition Type"; Option)
        {
            //CSPL-00307
            OptionMembers = "","Campus","New York";
            DataClassification = ToBeClassified;
        }
        field(50008; Remark; Text[250])
        {
            //CSPL-00307
            DataClassification = ToBeClassified;
        }
        field(50009; ModifiedOn; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50010; ModifiedBy; Code[50])
        {
            DataClassification = ToBeClassified;
        }

    }


    trigger OnDelete()
    begin
        RequisitionLineCS.Reset();
        RequisitionLineCS.SETRANGE("Document No.", "Indent No");
        RequisitionLineCS.SETRANGE("Line No.", "Indent Line No");
        IF RequisitionLineCS.FINDFIRST() THEN BEGIN
            RequisitionLineCS.Select := FALSE;
            RequisitionLineCS.Modify();
        END;
        //Code added for Requisition Line modify Select Field::CSPL-00136::30-04-2019: Start
        //CSPL-00307 Start
        ReqLine.reset();
        ReqLine.SetRange("Document No.", rec."Requisition No.");
        ReqLine.SetRange("Line No.", rec."Requisition Line No.");
        ReqLine.SetRange("Document Type", ReqLine."Document Type"::Requisition);
        if ReqLine.FindFirst() then begin
            ReqLine."PO No." := '';
            ReqLine.Modify();
        end;
        //CSPL-00307 End
    end;

    trigger OnModify()
    var
    // myInt: Integer;
    begin
        ModifiedBy := UserId;
        ModifiedOn := CurrentDateTime;
    end;

    var
        RequisitionLineCS: Record "Requisition Line-CS";
        ReqLine: record "Requisition Line_";
}

