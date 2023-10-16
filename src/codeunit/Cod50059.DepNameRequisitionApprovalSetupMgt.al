codeunit 50059 "Department Name Mgt."
{
    [EventSubscriber(ObjectType::Table, database::"Requisition Approval Setup", 'OnAfterValidateEvent', 'Global Dimension 2 Code', false, false)]
    local procedure DepartmentNameFromDepCode(var Rec: Record "Requisition Approval Setup")
    var
        DimensionValue: record "Dimension Value";
    begin
        DimensionValue.Reset();
        DimensionValue.SetRange(DimensionValue.Code, Rec."Global Dimension 2 Code");
        if DimensionValue.FindFirst() then begin
            rec.Validate("Department Name", DimensionValue.Name);
        end;
    end;
}