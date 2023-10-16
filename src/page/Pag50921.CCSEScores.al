page 50921 "CCSE Scores"
{
    Caption = 'CCSE Scores';
    Editable = true;
    PageType = List;
    PromotedActionCategories = 'New,Process,Navigate';
    UsageCategory = Lists;
    ApplicationArea = all;
    SourceTable = "CBSE CCSE Scores";
    SourceTableView = sorting("Entry No.")
                      order(ascending)
                      where(Type = filter(CCSE));

    layout
    {
        area(Content)
        {
            repeater(Group1)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Institution ID"; Rec."Institution ID")
                {
                    ApplicationArea = All;
                }
                field("Test Date"; Rec."Test Date")
                {
                    ApplicationArea = All;
                }
                field("Order Number"; Rec."Order Number")
                {
                    ApplicationArea = All;
                }
                field(Exam; Rec.Exam)
                {
                    ApplicationArea = All;
                }
                field(ID; Rec.ID)
                {
                    ApplicationArea = All;
                }
                field(Examinee; Rec.Examinee)
                {
                    ApplicationArea = All;
                }
                field("Total Test"; Rec."Total Test")
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field(Published; Rec.Published)
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
            group("Action")
            {

                Caption = 'Action';

                action("Upload CBSE Scores")
                {
                    ApplicationArea = All;
                    Caption = 'Upload CCSE Scores';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Import;
                    trigger OnAction()
                    begin
                        If Rec.Type = Rec.Type::CBSE then
                            Type1 := 1;
                        If Rec.Type = Rec.Type::CCSE then
                            Type1 := 2;
                        If Rec.Type = Rec.Type::CCSSE then
                            Type1 := 3;
                        CBSECCSEPort.GetType(Type1);
                        CBSECCSEPort.Run();
                        //Xmlport.Run(Xmlport::"CBSC Scores", false, true, Rec);
                    end;
                }
                action("Publish")
                {
                    ApplicationArea = All;
                    Caption = 'Publish';
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    Image = Import;
                    Visible = False;
                    trigger OnAction()
                    begin
                        RecCBSECCSE.Reset();
                        RecCBSECCSE.SetRange(Published, false);
                        RecCBSECCSE.SetRange(Type, RecCBSECCSE.Type::CCSE);
                        if RecCBSECCSE.FindFirst() then begin
                            repeat
                                RecCBSECCSE1.Reset();
                                RecCBSECCSE1.SetRange(ID, RecCBSECCSE.ID);
                                RecCBSECCSE1.SetRange("Test Date", RecCBSECCSE."Test Date");
                                RecCBSECCSE1.SetRange(Type, RecCBSECCSE1.Type::CCSE);
                                RecCBSECCSE1.SetRange(Published, true);
                                if RecCBSECCSE1.FindFirst() then begin
                                    Error('Data is already published for Student %1', RecCBSECCSE.ID);
                                end;
                                RecCBSECCSE.Published := true;
                                RecCBSECCSE.Modify();
                            until RecCBSECCSE.Next() = 0;
                        end else begin
                            Message('Data already Published');
                        end;
                    end;
                }

            }
        }
    }
    var
        RecCBSECCSE: Record "CBSE CCSE Scores";
        RecCBSECCSE1: Record "CBSE CCSE Scores";
        CBSECCSEPort: XmlPort "CBSC CCSE Scores";

        Type1: Integer;
}