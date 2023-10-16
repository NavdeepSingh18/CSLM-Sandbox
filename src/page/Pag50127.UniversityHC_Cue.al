page 50127 UniversityHCCue
{//CSPL-00307 - Insurance Waiver
    PageType = CardPart;
    RefreshOnActivate = true;
    Caption = 'University Health Center Role Center ';

    layout
    {
        area(Content)
        {
            cuegroup("Insurance Waiver Statistics")
            {


                field(PendingCount; PendingCount)
                {
                    Caption = 'Pending Insurance Waiver List';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Pending Insurance Waiver List";
                    trigger OnDrillDown()
                    var
                        RecInsuranceWaiver: Record "Student Rank-CS";
                        PendingInsurancePage: Page "Pending Insurance Waiver List";
                    begin
                        RecInsuranceWaiver.Reset();
                        RecInsuranceWaiver.SetFilter(Status, '%1', RecInsuranceWaiver.Status::Pending);
                        if RecInsuranceWaiver.FindSet() then begin
                            PendingInsurancePage.SetTableView(RecInsuranceWaiver);
                            PendingInsurancePage.SetRecord(RecInsuranceWaiver);
                            PendingInsurancePage.Run();
                        end;
                    end;
                }

                field(ApprovedCount; ApprovedCount)
                {
                    Caption = 'Approved Insurance Waiver List';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Pending Insurance Waiver List";
                    ;
                    trigger OnDrillDown()
                    var
                        RecInsuranceWaiver: Record "Student Rank-CS";
                        PendingInsurancePage: Page "Pending Insurance Waiver List";
                    begin
                        RecInsuranceWaiver.Reset();
                        RecInsuranceWaiver.SetFilter(Status, '%1', RecInsuranceWaiver.Status::Approved);
                        if RecInsuranceWaiver.FindSet() then begin
                            PendingInsurancePage.SetTableView(RecInsuranceWaiver);
                            PendingInsurancePage.SetRecord(RecInsuranceWaiver);
                            PendingInsurancePage.Run();
                        end;
                    end;
                }
                field(RejectedCount; RejectedCount)
                {
                    Caption = 'Rejected Insurance Waiver List';
                    ApplicationArea = Basic, Suite;
                    DrillDownPageId = "Pending Insurance Waiver List";
                    trigger OnDrillDown()
                    var
                        RecInsuranceWaiver: Record "Student Rank-CS";
                        PendingInsurancePage: Page "Pending Insurance Waiver List";
                    begin
                        RecInsuranceWaiver.Reset();
                        RecInsuranceWaiver.SetFilter(Status, '%1', RecInsuranceWaiver.Status::Rejected);
                        if RecInsuranceWaiver.FindSet() then begin
                            PendingInsurancePage.SetTableView(RecInsuranceWaiver);
                            PendingInsurancePage.SetRecord(RecInsuranceWaiver);
                            PendingInsurancePage.Run();
                        end;
                    end;
                }

            }
        }

    }
    trigger OnOpenPage()
    var

    begin
        Clear(PendingCount);
        Clear(ApprovedCount);
        Clear(RejectedCount);

        RecInsranceWaiverGlobal.Reset();
        RecInsranceWaiverGlobal.SetFilter("No.", '<>%1', '');
        RecInsranceWaiverGlobal.SetFilter(Status, '%1', RecInsranceWaiverGlobal.Status::Pending);
        if RecInsranceWaiverGlobal.FindSet() then
            PendingCount := RecInsranceWaiverGlobal.Count
        else
            PendingCount := 0;

        RecInsranceWaiverGlobal.Reset();
        RecInsranceWaiverGlobal.SetFilter("No.", '<>%1', '');
        RecInsranceWaiverGlobal.SetFilter(Status, '%1', RecInsranceWaiverGlobal.Status::Approved);
        if RecInsranceWaiverGlobal.FindSet() then
            ApprovedCount := RecInsranceWaiverGlobal.Count
        else
            ApprovedCount := 0;

        RecInsranceWaiverGlobal.Reset();
        RecInsranceWaiverGlobal.SetFilter("No.", '<>%1', '');
        RecInsranceWaiverGlobal.SetFilter(Status, '%1', RecInsranceWaiverGlobal.Status::Rejected);
        if RecInsranceWaiverGlobal.FindSet() then
            RejectedCount := RecInsranceWaiverGlobal.Count
        else
            RejectedCount := 0;

        CurrPage.Update();
    end;

    var
        RecInsranceWaiverGlobal: Record "Student Rank-CS";
        PendingCount: Integer;
        ApprovedCount: Integer;
        RejectedCount: Integer;
}
