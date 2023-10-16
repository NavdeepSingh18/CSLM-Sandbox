page 50544 "Student Wise Hold List"
{

    PageType = List;
    SourceTable = "Student Wise Holds";
    Caption = 'Student Wise Hold List';
    ApplicationArea = All;
    UsageCategory = Lists;
    DeleteAllowed = true;
    Editable = false;


    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;

                }
                field("First Name"; Rec."First Name")
                {
                    ToolTip = 'Specifies the value of the First Name field.';
                    ApplicationArea = All;
                    Enabled = false;
                    DrillDown = false;
                    //editable = false;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ToolTip = 'Specifies the value of the Last Name field.';
                    ApplicationArea = All;
                    Enabled = false;
                    DrillDown = false;
                    //editable = false;
                }
                field("Admitted Year"; Rec."Admitted Year")
                {
                    ApplicationArea = All;
                }
                field(Semester; Rec.Semester)
                {
                    ApplicationArea = All;
                }
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Hold Code"; Rec."Hold Code")
                {
                    ApplicationArea = All;
                }
                field("Hold Description"; Rec."Hold Description")
                {
                    ApplicationArea = All;
                }
                field("Hold Type"; Rec."Hold Type")
                {
                    ApplicationArea = All;
                }
                field("Group Code"; Rec."Group Code")
                {
                    ApplicationArea = All;
                }
                field("Sign-off"; Rec."Sign-off")
                {
                    ApplicationArea = All;
                }
                field("Potal Login Restriction"; Rec."Potal Login Restriction")
                {
                    ApplicationArea = All;
                }
                field("Transcript Print"; Rec."Transcript Print")
                {
                    ApplicationArea = All;
                }
                field(Progression; Rec.Progression)
                {
                    ApplicationArea = All;
                }
                field(Billing; Rec.Billing)
                {
                    ApplicationArea = All;
                }
                field("Clinical Rotation"; Rec."Clinical Rotation")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Visible = false;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Hold Enable/Disable")
            {
                Caption = '&Hold Enable/Disable';
                ApplicationArea = All;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                Visible = False;
                trigger OnAction()
                Var
                    StudentTimeLineRec: Record "Student Time Line";
                begin
                    HoldUserMappingRec.Reset();
                    HoldUserMappingRec.SetRange("User ID", UserId());
                    if HoldUserMappingRec.FindFirst() then begin
                        CurrPage.SetSelectionFilter(StudentWiseHoldRec);
                        HoldCount := StudentWiseHoldRec.Count();
                        IF HoldCount > 1 then begin
                            IF CONFIRM(Text001Lbl, FALSE) THEN BEGIN
                                IF StudentWiseHoldRec.FindSet() Then
                                    repeat
                                        // StudentWiseHoldRec1.Reset();
                                        // StudentWiseHoldRec1.SetRange("Student No.", StudentWiseHoldRec."Student No.");
                                        // StudentWiseHoldRec1.SetRange("Hold Code", StudentWiseHoldRec."Hold Code");
                                        // if StudentWiseHoldRec1.FINDFIRST() then begin
                                        if StudentWiseHoldRec.Status = StudentWiseHoldRec.Status::Enable then begin
                                            StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Disable);
                                            StudentTimeLineRec.InsertRecordFun(StudentWiseHoldRec."Student No.", StudentWiseHoldRec."Student Name", 'Student wise Hold Disable', UserId(), Today());
                                        end else begin
                                            StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Enable);
                                            StudentTimeLineRec.InsertRecordFun(StudentWiseHoldRec."Student No.", StudentWiseHoldRec."Student Name", 'Student wise Hold Enable', UserId(), Today());
                                        end;
                                        StudentWiseHoldRec.Modify();
                                    //  end;
                                    until StudentWiseHoldRec.NEXT() = 0;
                                Message(Text003Lbl);
                                CurrPage.Update();
                            end else
                                Exit;
                        end else
                            IF CONFIRM(Text002Lbl, FALSE, Rec."Student No.") THEN BEGIN
                                StudentWiseHoldRec.Reset();
                                StudentWiseHoldRec.SetRange("Student No.", Rec."Student No.");
                                StudentWiseHoldRec.SetRange("Hold Code", Rec."Hold Code");
                                if StudentWiseHoldRec.FINDFIRST() then begin
                                    if Rec.status = Rec.status::Enable then begin
                                        StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Disable);
                                        StudentTimeLineRec.InsertRecordFun(StudentWiseHoldRec."Student No.", StudentWiseHoldRec."Student Name", 'Student wise Hold Disable', UserId(), Today());
                                    End else begin
                                        StudentWiseHoldRec.Validate(Status, StudentWiseHoldRec.Status::Enable);
                                        StudentTimeLineRec.InsertRecordFun(StudentWiseHoldRec."Student No.", StudentWiseHoldRec."Student Name", 'Student wise Hold Enable', UserId(), Today());
                                    end;
                                    StudentWiseHoldRec.Modify();
                                end;
                                Message(Text004Lbl, Rec."Student No.");
                                CurrPage.Update();
                            end else
                                exit;
                    end else
                        Error('You do not have the permission to disable the holds');
                end;
            }
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
        }
    }
    Var
        StudentWiseHoldRec: Record "Student Wise Holds";
        HoldUserMappingRec: Record "Holds User Mapping";
        HoldCount: Integer;
        Text001Lbl: Label 'Do you want to Enable/Disable the selected Holds ?';
        Text002Lbl: Label 'Do you want to Enable/Disable Student No. %1 Hold?';
        Text003Lbl: Label 'The selected Holds has been Enabled/Disabled.';
        Text004Lbl: Label 'Student No. %1 hold has been Enabled/Disabled.';


}
