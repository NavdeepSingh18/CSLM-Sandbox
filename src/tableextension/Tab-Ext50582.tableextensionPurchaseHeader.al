tableextension 50582 "tableextension50582" extends "Purchase Header"
{
    // version NAVW19.00.00.46621,NAVIN9.00.00.46621,FIN1.0-CS

    // 1         CSPL-00307    12-10-21                     New Field Added 50004

    fields
    {
        modify("Shortcut Dimension 1 Code")
        {
            trigger OnAfterValidate()
            var
                page49: page "Purchase Order";
            begin

                IF Rec."Shortcut Dimension 1 Code" IN ['9000', '9100'] then
                    Rec.Validate("Requisition Type", Rec."Requisition Type"::Campus)
                else
                    Rec.Validate("Requisition Type", Rec."Requisition Type"::"New York");

                //22-12-21
                "Location Code" := ' ';
                IF Rec."Shortcut Dimension 1 Code" = '9100' then
                    Validate("Location Code", 'Antigua');
                IF Rec."Shortcut Dimension 1 Code" = '8000' then
                    Validate("Location Code", 'NEW YORK');
                //22-12-21

            end;

        }
        modify("Location Code")
        {
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false), "Requisition Type" = field("Requisition Type"));
            trigger OnBeforeValidate()
            var
            // myInt: Integer;
            begin
                IF Rec."Shortcut Dimension 1 Code" = '9100' then
                    TestField("Location Code", 'Antigua');
            end;

        }
        field(50000; "AMC PO"; Boolean)
        {
            Description = 'CS Field Added 02-05-2019';
        }
        field(50001; "AMC End Date"; Date)
        {
            Description = 'CS Field Added 02-05-2019';
        }

        field(50002; "Requisition No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Requisition Header"; //CSPL-00307
        }
        Field(50003; "Final Quotation"; Boolean)
        {
            DataClassification = CustomerContent;
            Trigger OnValidate()
            Var
                PurchLine: Record "Purchase Line";
            Begin
                PurchLine.Reset();
                PurchLine.SetRange("Document No.", Rec."No.");
                If PurchLine.FindSet() then begin
                    repeat
                        PurchLine.Validate("Final Quotation", Rec."Final Quotation");
                        PurchLine.Modify();
                    until PurchLine.Next() = 0;
                end
            End;
        }
        field(50004; "Requisition Type"; Option)
        {
            //CSPL-00307
            OptionMembers = "","Campus","New York";
            DataClassification = ToBeClassified;
        }
        field(50005; OrderCreated; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; ModifiedOn; DateTime)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; ModifiedBy; Code[50])
        {
            DataClassification = ToBeClassified;
        }
    }
    trigger OnDelete()
    var
        ReqLine: Record "Requisition Line_";
    begin
        //CSPL-00307 Start
        ReqLine.reset();
        ReqLine.SetRange("PO No.", Rec."No.");
        ReqLine.SetRange("Document Type", ReqLine."Document Type"::Requisition);
        if ReqLine.FindFirst() then begin
            ReqLine."PO No." := '';
            ReqLine.Modify();
        end;
        //CSPL-00307 End

        IF OrderCreated then
            Error('Order is Created for this Quotation You Can Not Delete');

    end;

    trigger OnModify()
    var
    // myInt: Integer;
    begin
        IF OrderCreated then
            Error('Order is Created for this Quotation You Can Not Modify');
        ModifiedBy := UserId;
        ModifiedOn := CurrentDateTime;
    end;

    trigger OnInsert()
    begin
        "Assigned User ID" := UserId; //CSPL-00307 12-11-21
    end;
}

