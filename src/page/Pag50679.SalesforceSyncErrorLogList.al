page 50679 "Salesforce Sync Error Log List"
{

    PageType = List;
    SourceTable = "Salesforce Sync Error Log";
    SourceTableView = sorting("Entry No.") ORDER(Descending);
    Caption = 'Salesforce Sync Error Log List';
    ApplicationArea = All;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field("Log Date"; Rec."Log Date")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field("Table ID"; Rec."Table ID")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field("Data Table Name"; Rec."Data Table Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field("Web Service Name"; Rec."Web Service Name")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field("Insert Event"; Rec."Insert Event")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }

                field("Update Event"; Rec."Update Event")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field("Error Description"; Rec."Error Description")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field(Data; Rec.Data)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field(URL; Rec.URL)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field("Body 1"; Rec."Body 1")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field("Body 2"; Rec."Body 2")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field(Method; Rec.Method)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field("Event Trigger"; Rec."Event Trigger")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field(Retry; Rec.Retry)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }
                field(Counter; Rec.Counter)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                }

            }
        }

    }

    actions
    {
        area(Processing)
        {
            action(DeleteEntries)
            {
                Caption = 'Delete Entries';
                ApplicationArea = All;
                Image = UpdateDescription;
                Promoted = true;
                PromotedOnly = true;
                PromotedCategory = Process;
                trigger OnAction()
                var
                    SalesForceError_lRec: Record "Salesforce Sync Error Log";
                begin
                    If Confirm('Do you want to Delete Successfully processed Entry', true) then begin
                        SalesForceError_lRec.Reset();
                        SalesForceError_lRec.SetRange(Retry, true);
                        SalesForceError_lRec.DeleteAll();
                    end Else
                        exit;
                end;
            }
            Action(ManualProcess)
            {
                Caption = 'Manual Process';
                ApplicationArea = All;
                Image = Process;
                Promoted = True;
                PromotedOnly = True;
                PromotedCategory = Process;
                Trigger OnAction()
                var
                    SLcMSalesForce_gCU: Codeunit SLcMToSalesforce;
                    lSuccessStatusCode: Boolean;
                    ReasonPhrs: Text;
                    ResData: Text[2048];
                Begin
                    lSuccessStatusCode := False;
                    ReasonPhrs := '';
                    ResData := '';
                    If Rec.Counter IN [0, 1, 2, 3, 4, 5, 99] then begin
                        SLcMSalesForce_gCU.SFInsert(Rec.URL, Rec.Method, Rec."Body 1", lSuccessStatusCode, ReasonPhrs, ResData);
                        If lSuccessStatusCode then begin
                            Rec.Counter := 0;
                            Rec.Retry := true;
                            Rec.Modify();
                        end Else
                            Error('Check the error manually');
                    end Else
                        Error('This will only work for entries highlighted in red.');
                End;
            }
        }

    }



    trigger OnAfterGetRecord()
    begin
        StyleTxt := StyleTxt;

    end;

    var
        StyleTxt: Text[100];
}
