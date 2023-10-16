page 60000 StudentDataVerse
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CDS cr33f_StudentMaster";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(cr33f_StudentMasterId; Rec.cr33f_StudentMasterId)
                {
                    ApplicationArea = All;

                }
                field(cr33f_StudentNo; Rec.cr33f_StudentNo)
                {
                    ApplicationArea = All;
                }
                field(cr33f_StudentName; Rec.cr33f_StudentName)
                {
                    ApplicationArea = All;
                }
                field(cr33f_Address; Rec.cr33f_Address)
                {
                    ApplicationArea = all;
                }
                field(cr33f_ContactNo; Rec.cr33f_ContactNo)
                {
                    ApplicationArea = All;
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(processing)
        {
            action(CreateFromCDS)
            {
                ApplicationArea = All;
                Caption = 'Create in Business Central';
                Promoted = true;
                PromotedCategory = Process;
                ToolTip = 'Generate the table from the coupled Microsoft Dataverse lab book.';

                trigger OnAction()
                var
                    CDSLabBook: Record "CDS cr33f_StudentMaster";
                    CRMIntegrationManagement: Codeunit "CRM Integration Management";
                begin
                    CurrPage.SetSelectionFilter(CDSLabBook);
                    CRMIntegrationManagement.CreateNewRecordsFromCRM(CDSLabBook);
                end;
            }
        }
    }

    var
        CurrentlyCoupledCDSLabBook: Record "CDS cr33f_StudentMaster";

    trigger OnInit()
    begin
        Codeunit.Run(Codeunit::"CRM Integration Management");
    end;

    procedure SetCurrentlyCoupledCDSLabBook(CDSLabBook: Record "CDS cr33f_StudentMaster")
    begin
        CurrentlyCoupledCDSLabBook := CDSLabBook;
    end;
}