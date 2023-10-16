page 50077 "OLR Returning Student Subform"
{
    PageType = ListPart;
    SourceTable = "OLR Update Line";
    AutoSplitKey = true;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(Select; Rec.Select)
                {
                    ApplicationArea = All;

                }
                field(Confirmed; Rec.Confirmed)
                {
                    ApplicationArea = All;
                    Editable = False;
                    StyleExpr = StyleTxt;
                }

                field(Reminder; Rec.Reminder)
                {
                    ApplicationArea = All;
                    Editable = False;
                }

                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;

                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;

                }
                field("Enrollment No."; Rec."Enrollment No.")
                {
                    ApplicationArea = All;

                }
                field("Original Student No."; Rec."Original Student No.")
                {
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;

                }

                Field("Current Student Status"; Rec."Current Student Status")
                {
                    ApplicationArea = All;
                }
                field("OLR Completed"; Rec."OLR Completed")
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;

                }
                field(Term; Rec.Term)
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;

                }
                field("Course Code"; Rec."Course Code")
                {
                    ApplicationArea = All;

                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;

                }
                field("Registrar Sign Off"; Rec."Registrar Sign Off")
                {
                    ApplicationArea = All;

                }
                field("OLR Start Date"; Rec."OLR Start Date")
                {
                    ApplicationArea = All;

                }
                field("OLR Academic Year"; Rec."OLR Academic Year")
                {
                    ApplicationArea = All;

                }
                field("OLR Term"; Rec."OLR Term")
                {
                    ApplicationArea = All;

                }
                field("OLR Semester"; Rec."OLR Semester")
                {
                    ApplicationArea = All;

                }
                field("Reminder No."; Rec."Reminder No.")
                {
                    ApplicationArea = All;
                }
            }
        }

    }

    actions
    {
        area(Processing)
        {
            action("Select All")
            {
                ApplicationArea = All;
                Image = EditList;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;
                PromotedIsBig = True;

                trigger OnAction()
                var
                    OLRUpdateLine_lRec: Record "OLR Update Line";
                begin
                    OLRUpdateLine_lRec.Reset();
                    OLRUpdateLine_lRec.SetRange("Document No.", Rec."Document No.");
                    OLRUpdateLine_lRec.SetRange(Select, false);
                    OLRUpdateLine_lRec.SetRange("Ready to Confirm", false);
                    IF OLRUpdateLine_lRec.FindSet() then begin
                        repeat
                            OLRUpdateLine_lRec.Select := true;
                            OLRUpdateLine_lRec.Modify();
                        until OLRUpdateLine_lRec.Next() = 0;
                    end;
                    CurrPage.Update();
                end;
            }

            action("Deselect All")
            {
                ApplicationArea = All;
                Image = EditList;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Category4;
                PromotedIsBig = True;

                trigger OnAction()
                var
                    OLRUpdateLine_lRec: Record "OLR Update Line";
                begin
                    OLRUpdateLine_lRec.Reset();
                    OLRUpdateLine_lRec.SetRange("Document No.", Rec."Document No.");
                    OLRUpdateLine_lRec.SetRange(Select, true);
                    //OLRUpdateLine_lRec.SetRange("Ready to Confirm", false);
                    IF OLRUpdateLine_lRec.FindSet() then begin
                        repeat
                            OLRUpdateLine_lRec.Select := false;
                            OLRUpdateLine_lRec.Modify();
                        until OLRUpdateLine_lRec.Next() = 0;
                    end;
                    CurrPage.Update();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        StyleTxt := Rec.Setstyle();

    end;

    var
        StyleTxt: Text[100];
}