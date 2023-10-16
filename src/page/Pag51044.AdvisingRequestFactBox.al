page 51044 "Advising Request Factbox"
{
    PageType = ListPart;
    UsageCategory = None;
    SourceTable = "Advising Request";
    Editable = False;
    //CardPageId = "MSPE Application Card";

    layout
    {
        area(Content)
        {
            group(Information)
            {
                Field("Student No."; Rec."Student No.")
                {
                    ApplicationArea = All;

                }
                Field("Student Name"; Rec."Student Name")
                {
                    ApplicationArea = All;
                }
                Field("Approved / Completed Count"; Completed_gInt)
                {
                    ApplicationArea = All;
                    Caption = 'Approved / Completed Count';
                    Trigger OnDrillDown()
                    var
                        AdvisingRequest_lRec: Record "Advising Request";
                        AppCmpltAdvisingRequest_lPage: Page "Advising Request Lists";
                    Begin
                        Clear(AppCmpltAdvisingRequest_lPage);
                        AdvisingRequest_lRec.Reset();
                        AdvisingRequest_lRec.SetRange("Student No.", Rec."Student No.");
                        AdvisingRequest_lRec.Setfilter("Request Status", '%1|%2', AdvisingRequest_lRec."Request Status"::Approved, AdvisingRequest_lRec."Request Status"::Completed);
                        AppCmpltAdvisingRequest_lPage.SetTableView(AdvisingRequest_lRec);
                        AppCmpltAdvisingRequest_lPage.Run();
                    End;
                }

                Field("Resheduled / Cancelled Count"; ResCan_gInt)
                {
                    ApplicationArea = All;
                    Caption = 'Resheduled / Cancelled Count';
                    Trigger OnDrillDown()
                    var
                        AdvisingRequest_lRec: Record "Advising Request";
                        AppCmpltAdvisingRequest_lPage: Page "Advising Request Lists";
                    Begin
                        Clear(AppCmpltAdvisingRequest_lPage);
                        AdvisingRequest_lRec.Reset();
                        AdvisingRequest_lRec.SetRange("Student No.", Rec."Student No.");
                        AdvisingRequest_lRec.Setfilter("Request Status", '%1|%2', AdvisingRequest_lRec."Request Status"::Cancel, AdvisingRequest_lRec."Request Status"::Rescheduled);
                        AppCmpltAdvisingRequest_lPage.SetTableView(AdvisingRequest_lRec);
                        AppCmpltAdvisingRequest_lPage.Run();
                    End;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        IntOption: Integer;
    Begin
        Completed_gInt := 0;
        AdvisingRequest_gRec.Reset();
        AdvisingRequest_gRec.SetRange("Student No.", Rec."Student No.");
        AdvisingRequest_gRec.SetFilter("Request Status", '%1|%2', AdvisingRequest_gRec."Request Status"::Approved, AdvisingRequest_gRec."Request Status"::Completed);
        IntOption := Rec.ChecDocumentAppDepartment();
        case IntOption of
            1:
                begin
                    AdvisingRequest_gRec.SetFilter("Department Type", format(Rec."Department Type"::"EED Pre-Clinical"));
                end;
            2:
                begin
                    AdvisingRequest_gRec.SetFilter("Department Type", format(Rec."Department Type"::"EED Clinical"));
                end;

            3:
                begin
                    AdvisingRequest_gRec.SetFilter("Department Type", '%1|%2', Rec."Department Type"::"EED Clinical", Rec."Department Type"::"EED Pre-Clinical");
                end;

        end;
        Completed_gInt := AdvisingRequest_gRec.Count();

        ResCan_gInt := 0;
        AdvisingRequest_gRec.Reset();
        AdvisingRequest_gRec.SetRange("Student No.", Rec."Student No.");
        AdvisingRequest_gRec.SetFilter("Request Status", '%1|%2', AdvisingRequest_gRec."Request Status"::Cancel, AdvisingRequest_gRec."Request Status"::Rescheduled);
        IntOption := Rec.ChecDocumentAppDepartment();
        case IntOption of
            1:
                begin
                    AdvisingRequest_gRec.SetFilter("Department Type", format(Rec."Department Type"::"EED Pre-Clinical"));
                end;
            2:
                begin
                    AdvisingRequest_gRec.SetFilter("Department Type", format(Rec."Department Type"::"EED Clinical"));
                end;

            3:
                begin
                    AdvisingRequest_gRec.SetFilter("Department Type", '%1|%2', Rec."Department Type"::"EED Clinical", Rec."Department Type"::"EED Pre-Clinical");
                end;

        end;
        ResCan_gInt := AdvisingRequest_gRec.Count();



    End;

    var
        AdvisingRequest_gRec: Record "Advising Request";
        Completed_gInt: Integer;
        ResCan_gInt: Integer;
}
