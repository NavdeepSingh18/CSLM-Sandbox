// page 50554 "Approval Requisition List"//GMCSCOM
// {
//     PageType = List;
//     ApplicationArea = All;
//     UsageCategory = Lists;
//     SourceTable = "Requisition Header";
//     Editable = false;
//     CardPageId = "Approval Requisition Card";
//     InsertAllowed = false;
//     SourceTableView = WHERE("Document Type" = FILTER(Requisition), "Responsible Department" = filter(Purchase), Status = filter("Pending for Approval"));

//     layout
//     {
//         area(Content)
//         {
//             repeater(Requisition)
//             {
//                 field("No."; Rec."No.")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Document Date"; Rec."Document Date")
//                 {
//                     ApplicationArea = all;
//                 }

//                 field("Approval Status"; Rec."Approval Status")
//                 {
//                     ApplicationArea = all;
//                 }

//                 field("1st Level Approval"; Rec."1st Level Approval")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("1st Level Approved Date"; Rec."1st Level Approved Date")
//                 {
//                     ApplicationArea = all;

//                 }
//                 field("1st Level Approver ID"; Rec."1st Level Approver ID")
//                 {
//                     ApplicationArea = all;

//                 }

//                 field("2nd Level Approval"; Rec."2nd Level Approval")
//                 {
//                     ApplicationArea = all;
//                 }

//                 field("2nd Level Approved Date"; Rec."2nd Level Approved Date")
//                 {
//                     ApplicationArea = all;

//                 }
//                 field("2nd Level Approver ID"; Rec."2nd Level Approver ID")
//                 {
//                     ApplicationArea = all;

//                 }
//                 field("3rd Level Approval"; Rec."3rd Level Approval")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("3rd Level Approved Date"; Rec."3rd Level Approved Date")
//                 {
//                     ApplicationArea = all;

//                 }
//                 field("3rd Level Approver ID"; Rec."3rd Level Approver ID")
//                 {
//                     ApplicationArea = all;

//                 }

//                 field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
//                 {
//                     ApplicationArea = all;
//                 }
//                 field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
//                 {
//                     ApplicationArea = all;
//                 }
//             }
//         }
//     }

//     actions
//     {
//         area(Processing)
//         {


//         }
//         area(Reporting)
//         {
//             action("Requisition Report")
//             {
//                 ApplicationArea = all;
//                 Image = Report;
//                 trigger OnAction()
//                 begin
//                     RecReqHeader.RESET();
//                     RecReqHeader.SETRANGE(RecReqHeader."Document Type", Rec."Document Type");
//                     RecReqHeader.SETRANGE(RecReqHeader."No.", Rec."No.");
//                     IF RecReqHeader.FIND('-') THEN
//                         REPORT.RUNMODAL(REPORT::"Requisition Report", TRUE, TRUE, RecReqHeader);
//                 end;
//             }
//         }
//     }
//     var
//         RecReqHeader: Record "Requisition Header";
//         RecUserSetup: Record "User Setup";

//     trigger OnOpenPage()
//     begin

//         RecUserSetup.GET(UserId());
//         Rec.FILTERGROUP(2);
//         Rec.SetFilter("Global Dimension 1 Code", '%1', RecUserSetup."Global Dimension 1 Code");
//         Rec.FILTERGROUP(0);
//         GetFilterUserID();
//     end;

//     trigger OnAfterGetRecord()
//     begin

//         RecUserSetup.GET(UserId());
//         Rec.FILTERGROUP(2);
//         Rec.SetFilter("Global Dimension 1 Code", '%1', RecUserSetup."Global Dimension 1 Code");
//         Rec.FILTERGROUP(0);

//     end;

//     procedure GetFilterUserID(): Text[100]
//     var
//         RecDimValue: Record "Dimension Value";
//         j: Integer;
//         Selection: Integer;
//         Text0055Lbl: Label '&Pending for 1st Level Approval,&Pending for 2nd Level Approval,&Pending for 3rd Level Approval';
//     begin
//         RecUserSetup.Reset();
//         RecUserSetup.GET(USERID());

//         RecDimValue.reset();
//         RecDimValue.SetRange(Code, RecUserSetup."Global Dimension 2 Code");
//         IF RecDimValue.FindFirst() then;
//         Rec.SetRange("Global Dimension 2 Code", RecUserSetup."Global Dimension 2 Code");

//         j := 0;
//         IF StrPos(RecDimValue."Requisition Approver Level 1", UserId()) > 0 THEN
//             J += 1;
//         IF StrPos(RecDimValue."Requisition Approver Level 2", UserId()) > 0 THEN
//             J += 1;
//         IF StrPos(RecDimValue."Requisition Approver Level 3", UserId()) > 0 THEN
//             J += 1;

//         IF j > 1 THEN begin
//             Selection := STRMENU(Text0055Lbl, 1);
//             IF Selection = 1 then begin
//                 IF StrPos(RecDimValue."Requisition Approver Level 1", UserId()) > 0 THEN
//                     // Rec.SetRange("Approval Status", "Approval Status"::"Pending For 1st Approval")GMCSCOM
//                     //else
//                     Error('You are not authorize for 1st Level Approval')
//             end;
//             IF Selection = 2 then begin
//                 IF StrPos(RecDimValue."Requisition Approver Level 2", UserId()) > 0 THEN begin
//                     Rec.SetRange("1st Level Approval", TRUE);
//                     //Rec.SetRange("Approval Status", "Approval Status"::"Pending For 2nd Approval");GMCSCOM
//                 end else
//                     Error('You are not authorize for 2nd Level Approval')
//             end;
//             IF Selection = 3 then begin
//                 IF StrPos(RecDimValue."Requisition Approver Level 3", UserId()) > 0 THEN begin
//                     Rec.SetRange("2nd Level Approval", TRUE);
//                     // Rec.SetRange("Approval Status", "Approval Status"::"Pending For 3rd Approval");GMCSCOM
//                 end else
//                     Error('You are not authorize for 3rd Level Approval')
//             end;

//         end ELSE begin

//             IF StrPos(UserId(), RecDimValue."Requisition Approver Level 1") > 0 THEN
//                 //Rec.SetRange("Approval Status", "Approval Status"::"Pending For 1st Approval");GMCSCOM

//             IF StrPos(UserId(), RecDimValue."Requisition Approver Level 2") > 0 THEN begin
//                     Rec.SetRange("1st Level Approval", TRUE);
//                     // Rec.SetRange("Approval Status", "Approval Status"::"Pending For 2nd Approval");GMCSCOM
//                 end;
//             IF StrPos(UserId(), RecDimValue."Requisition Approver Level 3") > 0 THEN begin
//                 Rec.SetRange("2nd Level Approval", TRUE);
//                 //Rec.SetRange("Approval Status", "Approval Status"::"Pending For 3rd Approval");//GMCSCOM
//             end;
//         end;

//     end;


// }