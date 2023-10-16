// dotnet
// {
//     assembly("mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
//     {
//         type(System.Array; Rec.MyText) { }
//     }
// }

// dotnet
// {
//     assembly("mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
//     {
//         type("System.String"; Rec.Value) { }
//     }

// }
// dotnet
// {
//     assembly("mscorlib, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089")
//     {
//         type("System.String"; Rec.Separater) { }
//     }

// }

// dotnet
// {
//     assembly("System.Net", Version=4.0.0.0, Culture=neutral, PublicKeyToken="b03f5f7f11d50a3a")
//     {
//         type("Http.HttpContent"; Rec.Bytes) { }
//     }
// }

page 50564 "Approval Requisition Card"
{
    PageType = Document;
    UsageCategory = none;
    SourceTable = "Requisition Header";
    DeleteAllowed = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            group(General)
            {
                // Editable = editgroups;
                //Editable = ApprovalStatus_Bool;
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                    StyleExpr = TRUE;
                    //Editable = FieldEdiable_bool;
                    Editable = ApprovalStatus_Bool;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.AssistEdit(xRec) THEN
                            CurrPage.UPDATE();
                    end;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                    // Editable = FieldEdiable_bool;
                    Editable = ApprovalStatus_Bool;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                    //Editable = FieldEdiable_bool;
                    Editable = ApprovalStatus_Bool;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                    //Editable = FieldEdiable_bool;
                    Editable = ApprovalStatus_Bool;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = all;
                    //Editable = FieldEdiable_bool;
                    Editable = ApprovalStatus_Bool;
                }

                field("Approval Status"; Rec."Approval Status")
                {
                    ApplicationArea = all;
                }

                field("Responsible Department"; Rec."Responsible Department")
                {
                    ApplicationArea = all;

                }

                field("1st Level Approval"; Rec."1st Level Approval")
                {
                    ApplicationArea = all;
                    Visible = Visible_Bool;

                }
                field("1st Level Approved Date"; Rec."1st Level Approved Date")
                {
                    ApplicationArea = all;
                    Visible = Visible_Bool;

                }
                field("1st Level Approver ID"; Rec."1st Level Approver ID")
                {
                    ApplicationArea = all;
                    Visible = Visible_Bool;

                }

                field("2nd Level Approval"; Rec."2nd Level Approval")
                {
                    ApplicationArea = all;
                    Visible = Visible_Bool;
                    //Editable = Status_bool;
                }

                field("2nd Level Approver Date"; Rec."2nd Level Approved Date")
                {
                    ApplicationArea = all;
                    Visible = Visible_Bool;

                }
                field("2nd Level Approver ID"; Rec."2nd Level Approver ID")
                {
                    ApplicationArea = all;
                    Visible = Visible_Bool;

                }
                field("3rd Level Approval"; Rec."3rd Level Approval")
                {
                    ApplicationArea = all;
                    Visible = Visible_Bool;

                }
                field("3rd Level Approver Date"; Rec."3rd Level Approved Date")
                {
                    ApplicationArea = all;
                    Visible = Visible_Bool;

                }
                field("3rd Level Approver ID"; Rec."3rd Level Approver ID")
                {
                    ApplicationArea = all;
                    Visible = Visible_Bool;

                }

                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = all;
                    // Editable = FieldEdiable_bool;
                    Editable = ApprovalStatus_Bool;
                }


                field(Reason; Rec.Reason)
                {
                    ApplicationArea = All;
                    Editable = Boolean_gBool;

                }
                field("Reason Description"; Rec."Reason Description")
                {
                    ApplicationArea = All;
                    Editable = Boolean_gBool;
                }
            }
            part("Requisition Subpage"; "Requisition Line Subpage")
            {
                ApplicationArea = All;
                //Editable = editgroups;
                Editable = ApprovalStatus_Bool;
                SubPageLink = "Document No." = field("No."), "Document Type" = field("Document Type");
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action("Approve")
            {
                ApplicationArea = All;
                Image = Approve;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = Boolean_gBool;
                // Visible = false;

                trigger OnAction()
                begin

                    // RequisitionApproval();

                END;
            }
            action("Reject")
            {
                ApplicationArea = All;
                Image = Reject;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Visible = Boolean_gBool;
                trigger OnAction()

                begin

                    // RequisitionReject();

                end;
            }


        }
        area(Reporting)
        {
            action("Requisition Report")
            {
                ApplicationArea = all;
                Image = Report;

                trigger OnAction()
                begin
                    RecReqHeader.RESET();
                    RecReqHeader.SETRANGE(RecReqHeader."Document Type", Rec."Document Type");
                    RecReqHeader.SETRANGE(RecReqHeader."No.", Rec."No.");
                    IF RecReqHeader.FIND('-') THEN
                        REPORT.RUNMODAL(REPORT::"Requisition Report", TRUE, TRUE, RecReqHeader);
                end;
            }
        }

    }

    var
        RecReqHeader: Record "Requisition Header";

        editgroups: Boolean;

        Text022Lbl: Label 'Do you want to Reject Requisition Doc. : %1';

        Boolean_gBool: Boolean;
        Boolean_gBool1: Boolean;
        Boolean_gBool2: Boolean;
        ApprovalStatus_Bool: Boolean;

        Status_bool: Boolean;
        Visible_Bool: Boolean;



    trigger OnInit();
    begin
        editgroups := true;
    end;

    trigger OnOpenPage()
    begin
        if not (Rec.Status = Rec.Status::Open) then begin
            editgroups := false;
        end else
            editgroups := true;



        Boolean_gBool := false;
        IF (Rec.Status = Rec.Status::"Pending for Approval") then
            Boolean_gBool := true;


        Boolean_gBool1 := false;
        IF Rec."Approval Status" = Rec."Approval Status"::Open then
            Boolean_gBool1 := true;

        Boolean_gBool2 := false;
        IF Rec."Approval Status" = Rec."Approval Status"::Approved then
            Boolean_gBool2 := true;

        Status_bool := True;
        IF Rec."Approval Status" = Rec."Approval Status"::Approved then
            Status_bool := False;


        ApprovalStatus_Bool := True;
        IF (Rec.Status = Rec.Status::"Pending for Approval") THEN
            ApprovalStatus_Bool := false;

        Visible_Bool := True;
        IF (Rec.Status = Rec.Status::Open) THEN
            Visible_Bool := false;

    end;

    trigger OnAfterGetRecord()
    begin
        if not (Rec.Status = Rec.Status::Open) then begin
            editgroups := false;
        end else
            editgroups := true;



        Boolean_gBool := false;
        IF (Rec.Status = Rec.Status::"Pending for Approval") then
            Boolean_gBool := true;


        Boolean_gBool1 := false;
        IF Rec."Approval Status" = Rec."Approval Status"::Open then
            Boolean_gBool1 := true;

        Boolean_gBool2 := false;
        IF Rec."Approval Status" = Rec."Approval Status"::Approved then
            Boolean_gBool2 := true;

        Status_bool := True;
        IF Rec."Approval Status" = Rec."Approval Status"::Approved then
            Status_bool := False;


        ApprovalStatus_Bool := True;
        IF (Rec.Status = Rec.Status::"Pending for Approval") THEN
            ApprovalStatus_Bool := false;


        Visible_Bool := True;
        IF (Rec.Status = Rec.Status::Open) THEN
            Visible_Bool := false;

    end;

    // procedure RequisitionApproval()
    // var

    //     RecDimValue: Record "Dimension Value";
    //     recUserSetup: Record "User Setup";
    //     Separater1: DotNet Separater;
    //     MyText1: DotNet MyText;
    //     Value1: DotNet Value;
    //     ApproverEmailID: Text[2048];
    //     FinalEmailId: text[2048];
    //     i: Integer;
    //     FString: Text[2048];
    //     txt000101Lbl: Label 'Do You want to approve 1st Level Approval?';
    //     txt000102Lbl: Label 'Do you want to approve 2nd Level Approval?';
    //     txt000103Lbl: Label 'Do you want to approve 3rd Level Approval?';
    //     EmailNewString: Text[2048];
    // begin

    //     RecDimValue.Reset();
    //     RecDimValue.SetRange(Code, "Global Dimension 2 Code");
    //     IF RecDimValue.FindFirst() THEN begin
    //         if StrPos(RecDimValue."Requisition Approver Level 1", USERID()) > 0 then begin
    //             IF ("Approval Status" = "Approval Status"::"Pending For 1st Approval") then begin
    //                 if Confirm(txt000101Lbl, false) then begin
    //                     "1st Level Approval" := TRUE;
    //                     "1st Level Approved Date" := Today();
    //                     "1st Level Approver ID" := FORMAT(USERID());
    //                     "Approval Status" := "Approval Status"::"Pending For 2nd Approval";
    //                     Modify();
    //                     EmailNewString := '';
    //                     FString := '';
    //                     //EmailNewString := ConvertStr(RecDimValue."Requisition Approver Level 1", '|', ';');
    //                     //ApprovalMail(EmailNewString, '1st Level Approved', 'Your Requisition 1st Level is Approved and "Pending For 2nd level Approval"');
    //                     ApproverEmailID := '';
    //                     EmailNewString := '';
    //                     Value1 := '';
    //                     FinalEmailId := '';
    //                     EmailNewString := ConvertStr(RecDimValue."Requisition Approver Level 1", '|', ',');
    //                     Value1 := EmailNewString;
    //                     Separater1 := ',';
    //                     MyText1 := Value1.Split(Separater1.ToCharArray());
    //                     FOR i := 0 to MyText1.Length() - 1 Do begin
    //                         recUserSetup.Reset();
    //                         recUserSetup.SetRange("User ID", MyText1.GetValue(i));
    //                         IF recUserSetup.FindSet() THEN begin
    //                             ApproverEmailID := recUserSetup."E-Mail";
    //                             FinalEmailId := FORMAT(FinalEmailId) + FORMAT(ApproverEmailID) + ';';
    //                         end;
    //                     end;
    //                     FString := FORMAT(COPYSTR(FinalEmailId, 1, STRLEN(FinalEmailId) - 1));
    //                     ApprovalMail(FString, '1st Level Approved', 'Your Requisition 1st Level is Approved and "Pending For 2nd level Approval"');
    //                 end;
    //             end;
    //         end;

    //         if StrPos(RecDimValue."Requisition Approver Level 2", USERID()) > 0 then begin
    //             IF ("Approval Status" = "Approval Status"::"Pending For 2nd Approval") then begin
    //                 if Confirm(txt000102Lbl, false) then begin
    //                     "2nd Level Approval" := TRUE;
    //                     "2nd Level Approved Date" := Today();
    //                     "2nd Level Approver ID" := FORMAT(USERID());
    //                     "Approval Status" := "Approval Status"::"Pending For 3Rd Approval";
    //                     Modify();
    //                     EmailNewString := '';
    //                     //EmailNewString := ConvertStr(RecDimValue."Requisition Approver Level 2", '|', ';');
    //                     //ApprovalMail(EmailNewString, '2nd Level Approved', 'Your Requisition 2nd Level is Approved and "Pending For 3rd level Approval"');
    //                     FString := '';
    //                     ApproverEmailID := '';
    //                     EmailNewString := '';
    //                     Value1 := '';
    //                     FinalEmailId := '';
    //                     EmailNewString := ConvertStr(RecDimValue."Requisition Approver Level 2", '|', ',');
    //                     Value1 := EmailNewString;
    //                     Separater1 := ',';
    //                     MyText1 := Value1.Split(Separater1.ToCharArray());
    //                     FOR i := 0 to MyText1.Length() - 1 Do begin
    //                         // Message('Value at Position %1: %2', I, MyText1.GetValue(i));
    //                         recUserSetup.Reset();
    //                         recUserSetup.SetRange("User ID", MyText1.GetValue(i));
    //                         IF recUserSetup.FindSet() THEN begin
    //                             ApproverEmailID := recUserSetup."E-Mail";
    //                             FinalEmailId := FORMAT(FinalEmailId) + FORMAT(ApproverEmailID) + ';';
    //                         end;
    //                     end;
    //                     FString := FORMAT(COPYSTR(FinalEmailId, 1, STRLEN(FinalEmailId) - 1));
    //                     ApprovalMail(FString, '2nd Level Approved', 'Your Requisition 2nd Level is Approved and "Pending For 3rd level Approval"');

    //                 end;
    //             end;
    //         end;
    //     end;

    //     if StrPos(RecDimValue."Requisition Approver Level 3", USERID()) > 0 then begin
    //         IF ("Approval Status" = "Approval Status"::"Pending For 3rd Approval") then begin
    //             if Confirm(txt000103Lbl, false) then begin
    //                 "3rd Level Approval" := TRUE;
    //                 "3rd Level Approved Date" := Today();
    //                 "3rd Level Approver ID" := FORMAT(USERID());
    //                 "Approval Status" := "Approval Status"::Approved;
    //                 Status := Status::Approved;
    //                 Modify();
    //                 EmailNewString := '';
    //                 FString := '';
    //                 //EmailNewString := ConvertStr(RecDimValue."Requisition Approver Level 3", '|', ';');
    //                 //ApprovalMail(EmailNewString, '3nd Level Approved', 'Your Requisition 3rd Level is Approved.');
    //                 ApproverEmailID := '';
    //                 EmailNewString := '';
    //                 Value1 := '';
    //                 FinalEmailId := '';
    //                 EmailNewString := ConvertStr(RecDimValue."Requisition Approver Level 3", '|', ',');
    //                 Value1 := EmailNewString;
    //                 Separater1 := ',';
    //                 MyText1 := Value1.Split(Separater1.ToCharArray());
    //                 FOR i := 0 to MyText1.Length() - 1 Do begin
    //                     //Message('Value at Position %1: %2', I, MyText1.GetValue(i));
    //                     recUserSetup.Reset();
    //                     recUserSetup.SetRange("User ID", MyText1.GetValue(i));
    //                     IF recUserSetup.FindSet() THEN begin
    //                         ApproverEmailID := recUserSetup."E-Mail";
    //                         FinalEmailId := FORMAT(FinalEmailId) + FORMAT(ApproverEmailID) + ';';
    //                     end;
    //                 end;
    //                 FString := FORMAT(COPYSTR(FinalEmailId, 1, STRLEN(FinalEmailId) - 1));
    //                 ApprovalMail(FString, '3rd Level Approved', 'Your Requisition 3rd Level is Approved.');
    //                 UpdateRequisitionLines(Rec, true);
    //                 CurrPage.Update(false);
    //                 CurrPage.Close()
    //             end;
    //         end;
    //     end;
    // end;


    // procedure RequisitionReject()
    // var
    //     RecUserSetup: Record "User Setup";
    //     RecDimValue: Record "Dimension Value";
    //     Separater1: DotNet Separater;
    //     MyText1: DotNet MyText;
    //     Value1: DotNet Value;
    //     ApproverEmailID: Text[2048];
    //     FinalEmailId: text[2048];
    //     i: Integer;
    //     FString: Text[2048];
    //     EmailNewString: Text[2048];

    // begin

    //     RecDimValue.Reset();
    //     RecDimValue.SetRange(Code, "Global Dimension 2 Code");
    //     IF RecDimValue.FindFirst() THEN begin
    //         if (StrPos(RecDimValue."Requisition Approver Level 1", USERID()) > 0) OR (StrPos(RecDimValue."Requisition Approver Level 2", USERID()) > 0) OR (StrPos(RecDimValue."Requisition Approver Level 3", USERID()) > 0) then begin
    //             testfield(reason);
    //             if Confirm(Text022Lbl, false, "No.") then begin
    //                 Status := Status::Open;
    //                 "Approval Status" := "Approval Status"::Open;
    //                 "Responsible Department" := "Responsible Department"::" ";
    //                 "1st Level Approval" := False;
    //                 "2nd Level Approval" := False;
    //                 "1st Level Approved Date" := 0D;
    //                 "1st Level Approver ID" := '';
    //                 "2nd Level Approved Date" := 0D;
    //                 "2nd Level Approver ID" := '';
    //                 Modify();
    //                 UpdateRequisitionLines(Rec, false);
    //                 EmailNewString := '';
    //                 FString := '';
    //                 //EmailNewString := ConvertStr(RecDimValue."Requisition Approver Level 3", '|', ';');
    //                 //ApprovalMail(EmailNewString, '3nd Level Approved', 'Your Requisition 3rd Level is Approved.');
    //                 ApproverEmailID := '';
    //                 EmailNewString := '';
    //                 Value1 := '';
    //                 FinalEmailId := '';
    //                 EmailNewString := ConvertStr(RecDimValue."Requisition Approver Level 3", '|', ',');
    //                 Value1 := EmailNewString;
    //                 Separater1 := ',';
    //                 MyText1 := Value1.Split(Separater1.ToCharArray());
    //                 FOR i := 0 to MyText1.Length() - 1 Do begin
    //                     //Message('Value at Position %1: %2', I, MyText1.GetValue(i));
    //                     recUserSetup.Reset();
    //                     recUserSetup.SetRange("User ID", MyText1.GetValue(i));
    //                     IF recUserSetup.FindSet() THEN begin
    //                         ApproverEmailID := recUserSetup."E-Mail";
    //                         FinalEmailId := FORMAT(FinalEmailId) + FORMAT(ApproverEmailID) + ';';
    //                     end;
    //                 end;
    //                 FString := FORMAT(COPYSTR(FinalEmailId, 1, STRLEN(FinalEmailId) - 1));
    //                 RejectedMail(FString, 'Approval Rejected', 'Your Requisition ' + "No." + ' is Rejected.');

    //                 //EmailNewString := ConvertStr(RecDimValue."Requisition Approver Level 1", '|', ',');
    //                 //ApprovalMail(EmailNewString, 'Approval Rejected', 'Your Requisition ' + "No." + ' is Rejected.');

    //                 CurrPage.Update(false);
    //                 CurrPage.Close();
    //             end;
    //         end else
    //             ERROR('You are not authorize the reject');

    //     end;
    // end;


}

