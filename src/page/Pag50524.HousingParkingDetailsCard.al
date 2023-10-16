page 50524 "Housing Parking Details Card"
{

    PageType = Card;
    SourceTable = "Housing Parking Details";
    Caption = 'Pending Parking Sticker Assignment Card';
    UsageCategory = None;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            Group(General)
            {
                field("Parking Application No."; Rec."Parking Application No.")
                {
                    ApplicationArea = All;
                    trigger OnAssistEdit()
                    begin
                        IF Rec.Assistedit(xRec) THEN
                            CurrPage.Update();
                    end;
                }
                field("Application Date"; Rec."Application Date")
                {
                    ApplicationArea = All;
                }
                field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;
                }
                field("Student Name"; Rec."Student Name")
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
                field("Academic Year"; Rec."Academic Year")
                {
                    ApplicationArea = All;
                }
                field("Registration Number"; Rec."Registration Number")
                {
                    ApplicationArea = All;
                }
                field("Vehicle Number"; Rec."Vehicle Number")
                {
                    ApplicationArea = All;
                }
                field("Name of Vehicle Owner"; Rec."Name of Vehicle Owner")
                {
                    ApplicationArea = All;
                }
                field("Number of Vehicle Owner"; Rec."Number of Vehicle Owner")
                {
                    ApplicationArea = All;
                }
                field("Driver License Number"; Rec."Driver License Number")
                {
                    ApplicationArea = All;
                }
                field("License Expiration Date"; Rec."License Expiration Date")
                {
                    ApplicationArea = All;
                }
                field(Make; Rec.Make)
                {
                    ApplicationArea = All;
                }
                field(Model; Rec.Model)
                {
                    ApplicationArea = All;
                }
                field(Colour; Rec.Colour)
                {
                    ApplicationArea = All;
                }
                field("Sticker Number"; Rec."Sticker Number")
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = true;

                }
                field("Pending Days"; PendingDaysCalculation())
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    Style = Strong;
                    StyleExpr = true;
                }
                field("Issued From"; Rec."Issued From")
                {
                    ApplicationArea = All;
                }
                field("Issued Upto"; Rec."Issued Upto")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                    MultiLine = true;
                }
                Field("Global Dimension 1 Code"; Rec."Global Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                Field("Global Dimension 2 Code"; Rec."Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Parking Type';
                }
            }
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
            action("Assigned Parking No")
            {
                ApplicationArea = All;
                Caption = 'Assigned Parking No';
                Visible = ShowButton;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                Promoted = true;
                Image = Close;
                trigger OnAction()
                begin
                    Rec.TestField("Global Dimension 2 Code");
                    Rec.TestField("Student No.");
                    Rec.TestField("Vehicle Number");
                    Rec.TestField("Name of Vehicle Owner");
                    Rec.TestField("Number of Vehicle Owner");
                    Rec.TestField("Registration Number");
                    Rec.TestField("Driver License Number");
                    Rec.TestField("License Expiration Date");
                    Rec.TestField(Make);
                    Rec.TestField(Model);
                    Rec.Testfield(Colour);
                    If Rec.Status = Rec.Status::"Pending for Approval" then
                        If Confirm(Txt001Lbl, false) then begin
                            // ParkingStickerAssignmentMail(Rec."Student No.");
                            Rec."Sticker Number" := Rec.ParkingAlloment();
                            Rec."Sticker Assigned Date" := WorkDate();
                            Rec.Status := Rec.Status::Approved;
                            Rec."Approved In Days" := Today() - Rec."Application Date";
                            Rec.Modify();
                            Message(Txt002Lbl, Rec."Sticker Number");
                            HousingParkingRec.RESET();
                            HousingParkingRec.SETRANGE("Parking Application No.", Rec."Parking Application No.");
                            IF HousingParkingRec.FINDFIRST() THEN
                                PAGE.RUN(50690, HousingParkingRec);
                        end;
                end;
            }
        }
    }
    Var
        HousingParkingRec: Record "Housing Parking Details";
        ShowButton: Boolean;
        Txt001Lbl: Label 'Do you want to assign the Parking No?';
        Txt002Lbl: Label 'Parking No %1 has been Assigned.';

    trigger OnAfterGetRecord()
    begin
        if Rec.Status = Rec.Status::"Pending for Approval" then
            ShowButton := true
        else
            ShowButton := false;
    end;

    trigger OnOpenPage()
    begin
        if Rec.Status = Rec.Status::"Pending for Approval" then
            ShowButton := true
        else
            ShowButton := false;
    end;

    procedure PendingDaysCalculation(): Integer
    Var
        PendingDays: Integer;
    begin
        if Rec."Application Date" <> 0D then begin
            PendingDays := Today() - Rec."Application Date";
            Exit(PendingDays);
        End else
            Exit(0);
    end;
}