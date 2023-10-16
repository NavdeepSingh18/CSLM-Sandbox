page 50654 "Apprvd Rejected Financial AID"
{
    PageType = Card;
    SourceTable = "Financial AID";
    Caption = 'Approved/Rejected Financial Aid Application';
    UsageCategory = none;
    RefreshOnActivate = true;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Application No."; Rec."Application No.")
                {
                    ApplicationArea = All;
                    Caption = 'Application No.';
                    Importance = Standard;

                    trigger OnAssistEdit()
                    begin
                        If Rec.AssistEdit(xRec) then
                            CurrPage.Update();
                    end;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                    Caption = 'Application Date';
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
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;

                }

                field("Date of Birth"; Rec."Date of Birth")
                {
                    ApplicationArea = All;
                }

                field("Email Id"; Rec."Email Id")
                {
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ApplicationArea = all;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field(Reason; Rec.Reason)
                {
                    Caption = 'Rejection Reason';
                    ApplicationArea = All;
                }
                field("Reason Description"; Rec."Reason Description")
                {
                    Caption = 'Rejection Reason Description';
                    ApplicationArea = All;
                    MultiLine = true;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Approved/Rejected By"; Rec."Approved/Rejected By")
                {
                    ApplicationArea = All;
                    Caption = 'Approved/Rejected By';
                }
                field("Approved/Rejected On"; Rec."Approved/Rejected On")
                {
                    ApplicationArea = All;
                }
                field("Created By"; Rec."Created By")
                {
                    ApplicationArea = All;
                }
                field("Created On"; Rec."Created On")
                {
                    ApplicationArea = All;
                }

            }
            group("Financial Aid")
            {
                field("Visited FAFSA Website"; Rec."Visited FAFSA Website")
                {
                    ApplicationArea = All;
                    Caption = 'www.fafsa.gov visited?';
                }
                field("Visited Student Loan Website"; Rec."Visited Student Loan Website")
                {
                    ApplicationArea = All;
                    Caption = 'www.studentloans.gov visited?';
                }
                field("FSA ID"; Rec."FSA ID")
                {
                    ApplicationArea = All;
                }
                field("Entrance Counseling"; Rec."Entrance Counseling")
                {
                    ApplicationArea = All;
                }
                field("Unsubsidized Loan"; Rec."Unsubsidized Loan")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CheckCasesBudgettedAmount();
                        IF (Rec."Unsubsidized Loan" = Rec."Unsubsidized Loan"::" ") OR
                         (Rec."Unsubsidized Loan" = Rec."Unsubsidized Loan"::NO) then
                            Rec."Unsubsidized Budgetted Amount" := 0;

                    end;
                }
                field("Direct Graduate plus loan"; Rec."Direct Graduate plus loan")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        CheckCasesBudgettedAmount();
                        Rec."Living expenses" := Rec."Living expenses"::" ";
                        IF (Rec."Direct Graduate plus loan" = Rec."Direct Graduate plus loan"::" ") OR
                        (Rec."Direct Graduate plus loan" = Rec."Direct Graduate plus loan"::NO) then
                            Rec."Graduate Plus Budgetted Amount" := 0;
                        StandardMaxDecision();
                    end;
                }
                field("Loan Expiry Date"; Rec."Loan Expiry Date")
                {
                    ApplicationArea = All;
                }
                field("Living expenses"; Rec."Living expenses")
                {
                    ApplicationArea = All;
                    Editable = Rec."Direct Graduate plus loan" = Rec."Direct Graduate plus loan"::YES;
                    trigger OnValidate()
                    begin
                        IF Rec."Living expenses" = Rec."Living expenses"::" " then begin
                            Rec."Graduate Plus Budgetted Amount" := 0;
                            Rec."Grad. Plus Transaction Amount" := 0;

                        end;
                        CheckCasesBudgettedAmount();
                        StandardMaxDecision();
                    end;
                }
                field("Standard or Max"; StanMax)
                {
                    // Caption = 'Standard or Max';
                    ApplicationArea = all;
                    Editable = false;
                }
                field("Grad PLUS MPN"; Rec."Grad PLUS MPN")
                {
                    ApplicationArea = all;
                }
            }
            group(Control0002)
            {
                Caption = 'Budget';
                field("Unsubsidized Budgetted Amount"; Rec."Unsubsidized Budgetted Amount")
                {
                    ApplicationArea = All;
                }

                field("Graduate Plus Budgetted Amount"; Rec."Graduate Plus Budgetted Amount")
                {
                    ApplicationArea = All;
                }
                field("Unsubsidized Transation Amount"; Rec."Unsubsidized Transation Amount")
                {
                    ApplicationArea = All;
                    Editable = Rec."Unsubsidized Loan" = Rec."Unsubsidized Loan"::YES;
                }

                field("Grad. Plus Transaction Amount"; Rec."Grad. Plus Transaction Amount")
                {
                    ApplicationArea = All;
                    Editable = Rec."Direct Graduate plus loan" = Rec."Direct Graduate plus loan"::YES;
                }
            }

            group(Control0006)
            {
                Caption = 'Denial Details';
                field("Grad PLUS Denial"; Rec."Grad PLUS Denial")
                {
                    ApplicationArea = All;
                }
            }
            group(Control0004)
            {
                Caption = 'Endorser Details';
                field(Endorse; Rec.Endorse)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        IF Rec.Endorse = Rec.Endorse::NO then
                            Rec."Loan Amount" := 0;
                        CurrPage.Update();
                    end;
                }
                field("Loan Amount"; Rec."Loan Amount")
                {
                    ApplicationArea = All;
                    Editable = Rec.Endorse = Rec.Endorse::YES;
                }

            }
            // group(Control0005)
            // {
            //     Caption = '';
            //     Visible = Endorse = Endorse::YES;
            //     field("Loan Amount"; Rec."Loan Amount")
            //     {
            //         ApplicationArea = All;
            //     }
            // }

        }
    }




    var
        FeeSetupRec: Record "Fee Setup-CS";
        StanMax: Text[15];
        PageEditable: Boolean;




    trigger OnOpenPage()
    begin
        StanMax := '';
        PageEditable := true;
        StandardMaxDecision();

    end;


    trigger OnNewRecord(BelowxRec: Boolean)

    begin
        Rec.Type := Rec.Type::"Financial Aid";
    end;

    trigger OnAfterGetRecord()
    Begin
        if Rec.Status in [Rec.Status::Approved, Rec.Status::Rejected] then
            PageEditable := false
        else
            PageEditable := true;
        CurrPage.Editable(PageEditable);
        CurrPage.Update();

        StandardMaxDecision();
    End;

    procedure CheckCasesBudgettedAmount()
    begin
        FeeSetupRec.Reset();
        FeeSetupRec.SetRange("Global Dimension 1 Code", Rec."Global Dimension 1 Code");
        FeeSetupRec.FindFirst();

        //Case1
        IF (Rec."Unsubsidized Loan" = Rec."Unsubsidized Loan"::YES) then
            Rec."Unsubsidized Budgetted Amount" := FeeSetupRec."Unsubsidized Budgetted Amount"
        else begin
            Rec."Unsubsidized Budgetted Amount" := 0;
            Rec."Unsubsidized Transation Amount" := 0;
        end;

        //Case2
        if (Rec."Direct Graduate plus loan" = Rec."Direct Graduate plus loan"::YES) AND
        ((Rec."Living expenses" = Rec."Living expenses"::NO) or (Rec."Living expenses" = Rec."Living expenses"::" ")) then
            Rec."Graduate Plus Budgetted Amount" := FeeSetupRec."Standard Cost";

        //Case3
        if (Rec."Direct Graduate plus loan" = Rec."Direct Graduate plus loan"::YES) AND
         (Rec."Living expenses" = Rec."Living expenses"::YES) then
            Rec."Graduate Plus Budgetted Amount" := FeeSetupRec."Graduate Plus Budgetted Amount";

        //Case4
        if Rec."Direct Graduate plus loan" in [Rec."Direct Graduate plus loan"::No, Rec."Direct Graduate plus loan"::" "] then begin
            Rec."Graduate Plus Budgetted Amount" := 0;
            Rec."Grad. Plus Transaction Amount" := 0;
        end;

    end;

    procedure StandardMaxDecision()
    begin
        StanMax := '';
        if (Rec."Direct Graduate plus loan" = Rec."Direct Graduate plus loan"::YES) and (Rec."Living expenses" = Rec."Living expenses"::YES) then
            StanMax := 'Max'
        else
            if (Rec."Direct Graduate plus loan" = Rec."Direct Graduate plus loan"::YES) and (Rec."Living expenses" = Rec."Living expenses"::NO) then
                StanMax := 'Standard Cost';
    end;


}
