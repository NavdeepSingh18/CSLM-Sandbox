page 50651 "Financial AID"
{
    PageType = Card;
    SourceTable = "Financial AID";
    Caption = 'Pending Financial Aid Application';
    UsageCategory = none;
    PromotedActionCategories = 'Process';
    RefreshOnActivate = true;
    // Editable = pageeditable;
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
                    // trigger OnValidate()
                    // begin
                    // CheckCasesBudgettedAmount();
                    // IF ("Unsubsidized Loan" = "Unsubsidized Loan"::" ") OR
                    //  ("Unsubsidized Loan" = "Unsubsidized Loan"::NO) then
                    //     "Unsubsidized Budgetted Amount" := 0;

                    // end;
                }
                field("Direct Graduate plus loan"; Rec."Direct Graduate plus loan")
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        // CheckCasesBudgettedAmount();
                        // "Living expenses" := "Living expenses"::" ";
                        // IF ("Direct Graduate plus loan" = "Direct Graduate plus loan"::" ") OR
                        // ("Direct Graduate plus loan" = "Direct Graduate plus loan"::NO) then
                        //     "Graduate Plus Budgetted Amount" := 0;
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
                        // IF "Living expenses" = "Living expenses"::" " then begin
                        //     "Graduate Plus Budgetted Amount" := 0;
                        //     "Grad. Plus Transaction Amount" := 0;

                        // end;
                        // CheckCasesBudgettedAmount();
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
                    Caption = 'Unsubsidized Transaction Amount';
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


    actions
    {
        area(Processing)
        {
            action("Student Card")
            {
                ApplicationArea = All;
                Image = Card;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Caption = 'Student Card';
                Runobject = page "Student Detail Card-CS";
                RunPageLink = "No." = FIELD("Student No.");
            }
            // action("Send for Approval")
            // {
            //     ApplicationArea = All;
            //     Caption = 'Send for Approval';
            //     Image = SendApprovalRequest;

            //     trigger OnAction()
            //     var
            //         Text50000Lbl: Label 'Do you want to Send Approval Request ?';
            //         Text50001Lbl: Label 'Approval request has been send successfully';
            //     begin
            //         TestField("Student No.");
            //         TestField("Global Dimension 1 Code");
            //         IF ("Unsubsidized Amount" = 0) AND ("Budgeted Cost" = 0) then
            //             Error('Unsubsidized Amount or Budgeted Cost must have a value');

            //         If Confirm(Text50000Lbl, True) then begin
            //             Status := Status::"Pending for Approval";
            //             Modify();
            //             CurrPage.Update();
            //             Message(Text50001Lbl);
            //         end ELSE
            //             exit;
            //     end;
            // }
            action(Approve)
            {
                ApplicationArea = All;
                Caption = 'Approve';
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                Image = Approve;
                trigger OnAction()
                var
                    Text50000Lbl: Label 'Do you want to approve this Application?';
                    Text50001Lbl: Label 'Application has been Approved';
                begin
                    If Rec.Status = Rec.Status::"Pending for Approval" then begin
                        If Confirm(Text50000Lbl, true) then begin

                            if Rec."Student No." = '' then
                                Error('Student No. is mandatory to approve the application');

                            if Rec."Unsubsidized Loan" = Rec."Unsubsidized Loan"::" " then
                                Error('Answer the Unsubsidized Loan related question');
                            if Rec."Direct Graduate plus loan" = Rec."Direct Graduate plus loan"::" " then
                                Error('Answer the Direct Graduate Plus Loan related question');
                            if (Rec."Direct Graduate plus loan" = Rec."Direct Graduate plus loan"::YES) and (Rec."Living expenses" = Rec."Living expenses"::" ") then
                                Error('Answer the Living Expense related question');
                            // if "Grad PLUS Denial" = "Grad PLUS Denial"::" " then
                            //     Error('Answer the Graduate Plus Denial related question');
                            if (Rec.Endorse = Rec.Endorse::YES) and (Rec."Loan Amount" <= 0) then
                                Error('Loan Amount must be mentioned if you answer YES to the Endorser related question');




                            if (Rec."Unsubsidized Loan" in [Rec."Unsubsidized Loan"::" ", Rec."Unsubsidized Loan"::No]) and (Rec."Unsubsidized Transation Amount" > 0) then
                                Error('Unsubsidized Transaction Amount must not be filled in, if it has not been applied');
                            if (Rec."Direct Graduate plus loan" in [Rec."Direct Graduate plus loan"::" ", Rec."Direct Graduate plus loan"::No]) and (Rec."Grad. Plus Transaction Amount" > 0) then
                                Error('Graduate Plus Transaction Amount must not be filled in, if it has not been applied');

                            if (Rec."Unsubsidized Loan" = Rec."Unsubsidized Loan"::YES) and (Rec."Direct Graduate plus loan" = Rec."Direct Graduate plus loan"::YES) then
                                if (Rec."Unsubsidized Transation Amount" <= 0) and (Rec."Grad. Plus Transaction Amount" <= 0) then
                                    Error('Application cannot be approved, if "Unsubsidized Transaction Amount" and "Graduate Plus Transaction Amount" both are zero');
                            if (Rec."Unsubsidized Loan" = Rec."Unsubsidized Loan"::YES) and (Rec."Direct Graduate plus loan" in [Rec."Direct Graduate plus loan"::NO, Rec."Direct Graduate plus loan"::" "]) then
                                if Rec."Unsubsidized Transation Amount" <= 0 then
                                    Error('Application cannot be approved, if "Unsubsidized Loan" is YES and "Unsubsidized Transaction Amount" is zero');

                            if (Rec."Direct Graduate plus loan" = Rec."Direct Graduate plus loan"::YES) and (Rec."Unsubsidized Loan" in [Rec."Unsubsidized Loan"::NO, Rec."Unsubsidized Loan"::" "]) then
                                if Rec."Grad. Plus Transaction Amount" <= 0 then
                                    Error('Application cannot be approved, if "Direct Graduate plus loan" is YES and "Graduate Plus Transaction Amount" is zero');

                            if Rec."Visited FAFSA Website" = Rec."Visited FAFSA Website"::" " then
                                Error('Please answer the question related to FAFSA Website');
                            if Rec."Visited Student Loan Website" = Rec."Visited Student Loan Website"::" " then
                                Error('Please answer the question related to Student Loan Website');
                            if Rec."Grad PLUS MPN" = Rec."Grad PLUS MPN"::" " then
                                Error('Please answer the question related to Graduate Plus MPN');


                            Rec.Status := Rec.Status::Approved;
                            Rec."Approved/Rejected By" := Format(UserId());
                            Rec."Approved/Rejected On" := WorkDate();
                            Rec.Modify();
                            recStudentMaster.Reset();
                            recStudentMaster.SetRange("No.", Rec."Student No.");
                            recStudentMaster.SetRange("Academic Year", Rec."Academic Year");
                            recStudentMaster.SetRange(Semester, Rec.Semester);
                            IF recStudentMaster.FindFirst() then begin
                                recStudentMaster.Validate("Financial Aid Approved", True);
                                recStudentMaster.Modify();
                            end;
                            //     RecStudentWiseHold.Reset();
                            //     RecStudentWiseHold.SetRange("Student No.", "Student No.");
                            //     RecStudentWiseHold.SetRange("Academic Year", "Academic Year");
                            //     RecStudentWiseHold.SetRange(Semester, Semester);
                            //     RecStudentWiseHold.SetRange("Hold Type", RecStudentWiseHold."Hold Type"::"Financial Aid");
                            //     IF RecStudentWiseHold.FindFirst() then begin
                            //         RecStudentWiseHold.Status := RecStudentWiseHold.Status::Disable;
                            //         IF RecStudentWiseHold.Modify() then begin
                            //             RecCodeUnit50037.HoldStatusLedgerEntryInsert("Student No.", RecStudentWiseHold."Hold Code",
                            //  RecStudentWiseHold."Hold Description", RecStudentWiseHold."Hold Type"::"Financial Aid", RecStudentWiseHold.Status::Disable);
                            // RecHoldStatusLedger.Reset();
                            // RecHoldStatusLedger.SetRange("Student No.", "Student No.");
                            // RecHoldStatusLedger.SetRange("Academic Year", "Academic Year");
                            // RecHoldStatusLedger.SetRange(Semester, Semester);
                            // RecHoldStatusLedger.SetRange("Hold Type", RecHoldStatusLedger."Hold Type"::" ");
                            // IF RecHoldStatusLedger.FindFirst() then begin
                            //     RecHoldStatusLedger."Table Caption" := TableName();
                            //     RecHoldStatusLedger."Hold Type" := RecHoldStatusLedger."Hold Type"::"Financial Aid";
                            //     RecHoldStatusLedger.Status := RecHoldStatusLedger.Status::Disable;
                            //     RecHoldStatusLedger.Modify();
                            // end;
                            //end;
                            // end;
                            //CurrPage.Update();
                            Message(Text50001Lbl);
                            //CurrPage.Close();
                        end;
                    end;
                end;
            }
            action(Reject)
            {
                ApplicationArea = All;
                Caption = 'Reject';
                Image = Reject;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    Text50000Lbl: Label 'Do you want to reject the Application?';
                    Text50001Lbl: Label 'Application has been Rejected';
                begin
                    If Rec.Status = Rec.Status::"Pending for Approval" then begin
                        Rec.TestField("Reason Description");
                        If Confirm(Text50000Lbl, true) then begin
                            Rec.Status := Rec.Status::Rejected;
                            Rec."Approved/Rejected By" := Format(UserId());
                            Rec."Approved/Rejected On" := Workdate();
                            Rec.Modify();
                            CurrPage.Update();
                            // FinancialAIDRequestRejected("Application No.", Type);
                            Message(Text50001Lbl);
                            CurrPage.Close();
                        end;
                    End;
                end;
            }
        }
    }

    var
        recStudentMaster: Record "Student Master-CS";
        RecStudentWiseHold: Record "Student Wise Holds";
        FeeSetupRec: Record "Fee Setup-CS";
        RecCodeUnit50037: Codeunit "Hosusing Mail";
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
        // if Status in [Status::Approved, Status::Rejected] then
        //     PageEditable := false
        // else
        PageEditable := true;
        // CurrPage.Editable(PageEditable);
        // CurrPage.Update();

        StandardMaxDecision();
    End;

    // procedure CheckCasesBudgettedAmount()
    // begin
    //     FeeSetupRec.Reset();
    //     FeeSetupRec.SetRange("Global Dimension 1 Code", "Global Dimension 1 Code");
    //     FeeSetupRec.FindFirst();

    //     //Case1
    //     IF ("Unsubsidized Loan" = "Unsubsidized Loan"::YES) then
    //         "Unsubsidized Budgetted Amount" := FeeSetupRec."Unsubsidized Budgetted Amount"
    //     else begin
    //         "Unsubsidized Budgetted Amount" := 0;
    //         "Unsubsidized Transation Amount" := 0;
    //     end;

    //     //Case2
    //     if ("Direct Graduate plus loan" = "Direct Graduate plus loan"::YES) AND
    //     (("Living expenses" = "Living expenses"::NO) or ("Living expenses" = "Living expenses"::" ")) then
    //         "Graduate Plus Budgetted Amount" := FeeSetupRec."Standard Cost";

    //     //Case3
    //     if ("Direct Graduate plus loan" = "Direct Graduate plus loan"::YES) AND
    //      ("Living expenses" = "Living expenses"::YES) then
    //         "Graduate Plus Budgetted Amount" := FeeSetupRec."Graduate Plus Budgetted Amount";

    //     //Case4
    //     if "Direct Graduate plus loan" in ["Direct Graduate plus loan"::No, "Direct Graduate plus loan"::" "] then begin
    //         "Graduate Plus Budgetted Amount" := 0;
    //         "Grad. Plus Transaction Amount" := 0;
    //     end;

    // end;

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
