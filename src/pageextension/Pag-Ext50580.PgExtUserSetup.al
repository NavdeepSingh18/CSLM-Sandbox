pageextension 50580 "PgExtUserSetup" extends "User Setup"
{
    layout
    {
        modify("Register Time")
        {
            Visible = true;
        }
        modify("Salespers./Purch. Code")
        {
            Visible = false;
        }
        modify("Sales Resp. Ctr. Filter")
        {
            Visible = false;
        }
        modify("Purchase Resp. Ctr. Filter")
        {
            Visible = false;
        }
        modify("Service Resp. Ctr. Filter")
        {
            Visible = false;
        }
        modify("Time Sheet Admin.")
        {
            Visible = false;
        }

        addafter("User ID")
        {
            field(UserName; UserName)
            {
                ApplicationArea = All;
            }
        }
        addafter("Allow Posting To")
        {

            field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
            field("Location Code"; Rec."Location Code")
            {
                ApplicationArea = All;
            }
            field("Department Approver"; Rec."Department Approver")
            {
                ApplicationArea = All;
            }
            field("Student Subject Permission"; Rec."Student Subject Permission")
            {
                ApplicationArea = All;
            }
            field("Grade Upload Allowed"; Rec."Grade Upload Allowed")
            {
                ApplicationArea = all;
            }
            field("Grade Modify Allowed"; Rec."Grade Modify Allowed")
            {
                ApplicationArea = all;
            }
            field("Education Setup Allowed"; Rec."Education Setup Allowed")
            {
                ApplicationArea = All;
            }
            field("Fee Setup Allowed"; Rec."Fee Setup Allowed")
            {
                ApplicationArea = All;
            }
            field("Academic Setup Allowed"; Rec."Academic Setup Allowed")
            {
                ApplicationArea = All;
            }
            field("Leaves Of Absence"; Rec."Leaves Of Absence")
            {
                ApplicationArea = All;
            }
            field("Change Status Allowed"; Rec."Change Status Allowed")
            {
                ApplicationArea = All;
            }
            field("Status Change Log Allowed"; Rec."Status Change Log Allowed")
            {
                ApplicationArea = All;
            }
            field("Published Score Delete Allowed"; Rec."Published Score Delete Allowed")
            {
                ApplicationArea = All;
            }
            field("User Setup Allowed"; Rec."User Setup Allowed")
            {
                ApplicationArea = All;
            }
            field("API URLs Allowed"; Rec."API URLs Allowed")
            {
                ApplicationArea = all;
            }
            field("Document Delete Allowed"; Rec."Document Delete Allowed")
            {
                ApplicationArea = all;
            }
            field("Transcript Print Allowed"; Rec."Transcript Print Allowed")
            {
                ApplicationArea = all;
            }

            field("Clinical Administrator"; Rec."Clinical Administrator")
            {
                ApplicationArea = all;
            }
            field("Bursar Clinical Administrator"; Rec."Bursar Clinical Administrator")
            {
                ApplicationArea = all;
            }
            field("Transcript Hold Allowed"; Rec."Transcript Hold Allowed")
            {
                ApplicationArea = all;
            }
            Field("GPA Calculation Allowed"; Rec."GPA Calculation Allowed")
            {
                ApplicationArea = all;
            }
            field("OLR Retuning Student Data Update"; Rec."OLR Retuning Student Data Update")
            {
                ApplicationArea = All;
            }
            field("SSN Permissions"; Rec."SSN Permissions")
            {
                ApplicationArea = All;
            }
            field("Course Change Permission"; Rec."Course Change Permission")
            {
                ApplicationArea = All;
            }
            Field("Ferpa Insert Allowed"; Rec."Ferpa Insert Allowed")
            {
                ApplicationArea = All;
            }
            Field("Rotation Deletion Allowed"; Rec."Rotation Deletion Allowed")
            {
                ApplicationArea = All;
            }
            Field("Housing Vacate Permission"; Rec."Housing Vacate Permission")
            {
                ApplicationArea = All;
            }
            Field("NMI Authorization Permission"; Rec."NMI Authorization Permission")
            {
                ApplicationArea = All;
            }
            Field("Export Batch Transcript"; Rec."Export Batch Transcript")
            {
                ApplicationArea = All;
            }
            Field("SSE Delete Permission"; Rec."SSE Delete Permission")
            {
                ApplicationArea = All;
            }
            field("Assign F Grade Allowed"; Rec."Assign F Grade Allowed")
            {
                ToolTip = 'Specifies the value of the Assign F Grade Allowed field.';
                ApplicationArea = All;
            }
            field("EED Chair"; Rec."EED Chair")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the EED Chair field.';
            }
            Field("Job Title"; Rec."Job Title")
            {
                ApplicationArea = All;
            }
            field("Housing Cost Permission"; Rec."Housing Cost Permission")
            {
                ApplicationArea = all;
            }
            field("No. Series Permission"; Rec."No. Series Permission")
            {
                ApplicationArea = all;
            }
            field("View Attendance Tracking"; Rec."View Attendance Tracking")
            {//CSPL-00307 T1-T1518
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the View Attendance Tracking field.';
            }
            field("Edit Attendance Tracking"; Rec."Edit Attendance Tracking")
            {//CSPL-00307 T1-T1518
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Edit Attendance Tracking field.';
            }
            field("User Task Permission"; Rec."User Task Permission")
            {
                ApplicationArea = All;
            }

        }
    }

    actions
    {
        addlast(Creation)
        {
            action("Document Approver List")
            {
                ApplicationArea = All;
                PromotedOnly = true;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                RunObject = page "Document Approver User List";
                RunPageLink = "User ID" = field("User ID");
            }
        }
        addfirst(Navigation)
        {
            action(Signatures)
            {
                ApplicationArea = all;
                Caption = 'Signature';
                trigger OnAction()
                begin
                    UploadImage();
                end;
            }
        }


    }
    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        // IF UserSetup.GET(UserId()) THEN
        //     IF not UserSetup."User Setup Allowed" THEN
        //         Error('You are not authorized');

    end;

    trigger OnDeleteRecord(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        // IF UserSetup.GET(UserId()) THEN
        //     IF not UserSetup."User Setup Allowed" THEN
        //         Error('You are not authorized');

    end;

    trigger OnOpenPage()
    var
        UserSetup: Record "User Setup";
    begin
        // UserSetup.GET(UserId());
        // IF not UserSetup."User Setup Allowed" THEN
        //     Error('You are not authorized to open User Setup');
    end;

    trigger OnModifyRecord(): Boolean
    var
        UserSetup: Record "User Setup";
    begin
        // IF UserSetup.GET(UserId()) THEN
        //     IF not UserSetup."User Setup Allowed" THEN
        //         Error('You are not authorized');

    end;

    trigger OnAfterGetRecord()
    begin
        Clear(UserName);
        UserTable.Reset();
        UserTable.SetRange("User Name", Rec."User ID");
        if UserTable.FindFirst() then
            UserName := UserTable."Full Name";
    end;

    // trigger OnQueryClosePage(CloseAction: Action): Boolean
    // var
    //     UserSetup: Record "User Setup";
    // begin
    //     // IF UserSetup.GET(UserId()) THEN begin
    //     //     CheckUserId := StrPos(UserId, 'MANIPALADMIN');
    //     //     if CheckUserId = 1 then begin
    //     //         IF not UserSetup."User Setup Allowed" THEN
    //     //             Error('You are not authorized');
    //     //     end;
    //     // end;
    // end;

    var
        UserName: Text[250];

        UserTable: Record User;

        CheckUserId: Integer;

    procedure UploadImage()
    var
        InS: InStream;
        OutS: OutStream;
        FileName: Text;
        tempblob: Codeunit "Temp Blob";
    begin
        if UploadIntoStream('Import', '', '', FileName, InS) then begin
            TempBlob.CreateOutStream(OutS);
            CopyStream(OutS, InS);
            Rec.CalcFields(Signature);
            Rec.Signature.CreateOutStream(OutS);
            TempBlob.CreateInStream(InS);
            CopyStream(OutS, InS);
            Rec.Modify();
        end;
    end;

}