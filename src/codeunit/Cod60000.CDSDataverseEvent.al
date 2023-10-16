codeunit 60000 CDSDataverse
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnGetCDSTableNo', '', false, False)]
    Local Procedure HandleOnGetCDSTableNo(BCTableNo: Integer; var CDSTableNo: Integer; var handled: Boolean)
    Begin
        If BCTableNo = Database::"Student Master-CS" then begin
            CDSTableNo := Database::"CDS cr33f_StudentMaster";
            handled := true;
        end;
    End;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Lookup CRM Tables", 'OnLookupCRMTables', '', False, false)]
    Local procedure HandleOnlookupCRMTables(CRMTableID: Integer; NAVTableId: Integer; SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text; var Handled: Boolean)
    begin
        If CRMTableID = Database::"CDS cr33f_StudentMaster" then
            Handled := LookupCDSLabBook(SavedCRMId, CRMId, IntTableFilter);

    end;

    local procedure LookupCDSLabBook(SavedCRMId: Guid; var CRMId: Guid; IntTableFilter: Text): Boolean
    var
        CDSLabBook: Record "CDS cr33f_StudentMaster";
        OriginalCDSLabBook: Record "CDS cr33f_StudentMaster";
        OriginalCDSLabBookList: Page StudentDataVerse;
    begin
        if not IsNullGuid(CRMId) then begin
            if CDSLabBook.Get(CRMId) then
                OriginalCDSLabBookList.SetRecord(CDSLabBook);
            if not IsNullGuid(SavedCRMId) then
                if OriginalCDSLabBook.Get(SavedCRMId) then
                    OriginalCDSLabBookList.SetCurrentlyCoupledCDSLabBook(OriginalCDSLabBook);
        end;

        CDSLabBook.SetView(IntTableFilter);
        OriginalCDSLabBookList.SetTableView(CDSLabBook);
        OriginalCDSLabBookList.LookupMode(true);
        if OriginalCDSLabBookList.RunModal = ACTION::LookupOK then begin
            OriginalCDSLabBookList.GetRecord(CDSLabBook);
            CRMId := CDSLabBook.cr33f_StudentMasterId;
            exit(true);
        end;
        exit(false);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CRM Setup Defaults", 'OnAddEntityTableMapping', '', true, true)]
    local procedure HandleOnAddEntityTableMapping(var TempNameValueBuffer: Record "Name/Value Buffer" temporary);
    begin
        AddEntityTableMapping('StudentMaster', DATABASE::"CDS cr33f_StudentMaster", TempNameValueBuffer);
    end;

    local procedure AddEntityTableMapping(CRMEntityTypeName: Text; TableID: Integer; var TempNameValueBuffer: Record "Name/Value Buffer" temporary)
    begin
        TempNameValueBuffer.Init();
        TempNameValueBuffer.ID := TempNameValueBuffer.Count + 1;
        TempNameValueBuffer.Name := CopyStr(CRMEntityTypeName, 1, MaxStrLen(TempNameValueBuffer.Name));
        TempNameValueBuffer.Value := Format(TableID);
        TempNameValueBuffer.Insert();
    end;

    local procedure InsertIntegrationTableMapping(var IntegrationTableMapping: Record "Integration Table Mapping"; MappingName: Code[20]; TableNo: Integer; IntegrationTableNo: Integer; IntegrationTableUIDFieldNo: Integer; IntegrationTableModifiedFieldNo: Integer; TableConfigTemplateCode: Code[10]; IntegrationTableConfigTemplateCode: Code[10]; SynchOnlyCoupledRecords: Boolean)
    begin
        IntegrationTableMapping.CreateRecord(MappingName, TableNo, IntegrationTableNo, IntegrationTableUIDFieldNo, IntegrationTableModifiedFieldNo, TableConfigTemplateCode, IntegrationTableConfigTemplateCode, SynchOnlyCoupledRecords, IntegrationTableMapping.Direction::Bidirectional, 'CDS');
    end;

    procedure InsertIntegrationFieldMapping(IntegrationTableMappingName: Code[20]; TableFieldNo: Integer; IntegrationTableFieldNo: Integer; SynchDirection: Option; ConstValue: Text; ValidateField: Boolean; ValidateIntegrationTableField: Boolean)
    var
        IntegrationFieldMapping: Record "Integration Field Mapping";
    begin
        IntegrationFieldMapping.CreateRecord(IntegrationTableMappingName, TableFieldNo, IntegrationTableFieldNo, SynchDirection,
            ConstValue, ValidateField, ValidateIntegrationTableField);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CDS Setup Defaults", 'OnAfterResetConfiguration', '', true, true)]
    local procedure HandleOnAfterResetConfiguration(CDSConnectionSetup: Record "CDS Connection Setup")
    var
        IntegrationTableMapping: Record "Integration Table Mapping";
        IntegrationFieldMapping: Record "Integration Field Mapping";
        CDSLabBook: Record "CDS cr33f_StudentMaster";
        LabBook: Record "Student Master-CS";
    begin
        InsertIntegrationTableMapping(
            IntegrationTableMapping, 'StudentMaster',
            DATABASE::"Student Master-CS", DATABASE::"CDS cr33f_StudentMaster", CDSLabBook.FieldNo(cr33f_StudentMasterId), CDSLabBook.FieldNo(ModifiedOn), '', '', true);

        InsertIntegrationFieldMapping('StudentMaster', LabBook.FieldNo("No."), CDSLabBook.FieldNo(cr33f_StudentNo), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('StudentMaster', LabBook.FieldNo("Student Name"), CDSLabBook.FieldNo(cr33f_StudentName), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('StudentMaster', LabBook.FieldNo(Addressee), CDSLabBook.FieldNo(cr33f_Address), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        InsertIntegrationFieldMapping('StudentMaster', LabBook.FieldNo("Mobile Number"), CDSLabBook.FieldNo(cr33f_ContactNo), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
        //InsertIntegrationFieldMapping('StudentMaster', LabBook.FieldNo("Page Count"), CDSLabBook.FieldNo(cr703_PageCount), IntegrationFieldMapping.Direction::Bidirectional, '', true, false);
    end;
}
