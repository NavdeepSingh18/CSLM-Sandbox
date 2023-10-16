page 50529 "ELOA Pending Approval"
{

    PageType = List;
    SourceTable = "50349";
    Caption = 'ELOA Pending Approval';
    CardPageId = "ELOA Card";
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTableView = where("Leave Types" = filter(ELOA), "Registrar" = filter(false));
    Editable = false;
    RefreshOnActivate = True;
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;

                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }

                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;

                }
                field("Enrolment No."; Rec."Enrolment No.")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;

                }
                field("Start Date"; Rec."Start Date")
                {
                    ApplicationArea = All;

                }
                field("End Date"; Rec."End Date")
                {
                    ApplicationArea = All;

                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;

                }
                field("Leave Types"; Rec."Leave Types")
                {
                    ApplicationArea = All;

                }

                field("Library Department"; Rec."Library Department")
                {
                    ApplicationArea = All;

                }
                field("Bursar Department"; Rec."Bursar Department")
                {
                    ApplicationArea = All;

                }
                field("Financial Aid Department"; Rec."Financial Aid Department")
                {
                    ApplicationArea = All;

                }
                field("EED Basic Science Department"; Rec."EED Basic Science Department")
                {
                    ApplicationArea = All;
                    Caption = 'EED Pre-Clinical Department';

                }
                field("Dean of Students affairs"; Rec."Dean of Students affairs")
                {
                    ApplicationArea = All;

                }
                field("Executive Dean"; Rec."Executive Dean")
                {
                    ApplicationArea = All;

                }
                field(Registrar; Rec.Registrar)
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



        }

    }
    var


    trigger OnOpenPage()
    var
        recUserSetup: Record "User Setup";
    begin
        IF recUserSetup.GET(USERID()) THEN BEGIN
            Rec.FILTERGROUP(2);
            Rec.SetFilter("Library Department", '<>%1|<>%2|<>%3|<>%4|<>%5', Rec."Library Department"::Open, Rec."Bursar Department"::"Open", Rec."Financial Aid Department"::"Open"
             , Rec."EED Basic Science Department"::"Open", Rec."Dean of Students affairs"::"Open", Rec."Executive Dean"::"Open");
            Rec.FILTERGROUP(0);
        END;

    end;

    trigger OnAfterGetRecord()
    begin
        IF (Rec."Library Department" = Rec."Library Department"::Approved) and
            (Rec."Bursar Department" = Rec."Bursar Department"::Approved) and
            (Rec."Financial Aid Department" = Rec."Financial Aid Department"::Approved) and
            (Rec."EED Basic Science Department" = Rec."EED Basic Science Department"::Approved) and
            (Rec."Dean of Students affairs" = Rec."Dean of Students affairs"::Approved) and
            (Rec."Executive Dean" = Rec."Executive Dean"::Approved) then begin
            Rec.Registrar := True;
            Rec.Modify();
        end;
    end;
}
