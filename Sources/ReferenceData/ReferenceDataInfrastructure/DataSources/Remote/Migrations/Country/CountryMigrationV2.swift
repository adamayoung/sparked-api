//
//  CountryMigrationV2.swift
//  SparkedAPI
//
//  Created by Adam Young on 14/03/2025.
//

import Fluent
import Foundation

struct CountryMigrationV2: AsyncMigration {

    func prepare(on database: any Database) async throws {
        try await database.transaction { database in
            for country in Self.countries {
                try await country.save(on: database)
            }
        }
    }

    func revert(on database: any Database) async throws {
        try await database.transaction { database in
            for country in Self.countries {
                try await CountryModel
                    .find(country.requireID(), on: database)?
                    .delete(force: true, on: database)
            }
        }
    }

}

extension CountryMigrationV2 {

    static let countries = [
        CountryModel(
            id: UUID(uuidString: "CB06938C-4A37-41B3-B535-C45CE15035C7"),
            code: "AC",
            name: "Ascension Island",
            nameKey: "REFERENCE_DATA.COUNTRY.ASCENSION_ISLAND"
        ),
        CountryModel(
            id: UUID(uuidString: "B4E1E08B-CE80-47F0-BE5C-7F38659AEA32"),
            code: "AD",
            name: "Andorra",
            nameKey: "REFERENCE_DATA.COUNTRY.ANDORRA"
        ),
        CountryModel(
            id: UUID(uuidString: "01CACFB0-D72C-415E-9116-30E874BBABCD"),
            code: "AE",
            name: "United Arab Emirates",
            nameKey: "REFERENCE_DATA.COUNTRY.UNITED_ARAB_EMIRATES"
        ),
        CountryModel(
            id: UUID(uuidString: "EB2EA5F0-73C6-41D6-BD9B-55C736C62DE8"),
            code: "AF",
            name: "Afghanistan",
            nameKey: "REFERENCE_DATA.COUNTRY.AFGHANISTAN"
        ),
        CountryModel(
            id: UUID(uuidString: "C3CEF6D6-228B-4B19-9C80-1812B6C3439E"),
            code: "AG",
            name: "Antigua & Barbuda",
            nameKey: "REFERENCE_DATA.COUNTRY.ANTIGUA_AND_BARBUDA"
        ),
        CountryModel(
            id: UUID(uuidString: "673997A1-6E28-47E8-B106-62C90A9707F0"),
            code: "AI",
            name: "Anguilla",
            nameKey: "REFERENCE_DATA.COUNTRY.ANGUILLA"
        ),
        CountryModel(
            id: UUID(uuidString: "AEB8CA65-43B8-4A5C-8AA7-41358BD59861"),
            code: "AL",
            name: "Albania",
            nameKey: "REFERENCE_DATA.COUNTRY.ALBANIA"
        ),
        CountryModel(
            id: UUID(uuidString: "A835BCDA-A8F2-492C-9B44-ED592029E454"),
            code: "AM",
            name: "Armenia",
            nameKey: "REFERENCE_DATA.COUNTRY.ARMENIA"
        ),
        CountryModel(
            id: UUID(uuidString: "38BE6F08-7FA0-43B8-B0C9-DEDA6CC42317"),
            code: "AO",
            name: "Angola",
            nameKey: "REFERENCE_DATA.COUNTRY.ANGOLA"
        ),
        CountryModel(
            id: UUID(uuidString: "E1F927C3-2AC5-42C6-B3D3-17E18704C6F2"),
            code: "AQ",
            name: "Antarctica",
            nameKey: "REFERENCE_DATA.COUNTRY.ANTARCTICA"
        ),
        CountryModel(
            id: UUID(uuidString: "99D8211D-1FF8-4411-894E-99AED2EC8165"),
            code: "AR",
            name: "Argentina",
            nameKey: "REFERENCE_DATA.COUNTRY.ARGENTINA"
        ),
        CountryModel(
            id: UUID(uuidString: "30812263-E0C0-4E7D-B081-34A99366FA7E"),
            code: "AS",
            name: "American Samoa",
            nameKey: "REFERENCE_DATA.COUNTRY.AMERICAN_SAMOA"
        ),
        CountryModel(
            id: UUID(uuidString: "0D087CD0-9853-4992-AFC2-8093B5393554"),
            code: "AT",
            name: "Austria",
            nameKey: "REFERENCE_DATA.COUNTRY.AUSTRIA"
        ),
        CountryModel(
            id: UUID(uuidString: "4B84E5E0-3A1B-4123-B842-27E944D0ABBF"),
            code: "AU",
            name: "Australia",
            nameKey: "REFERENCE_DATA.COUNTRY.AUSTRALIA"
        ),
        CountryModel(
            id: UUID(uuidString: "BD483D8C-DDC0-443B-A736-845125915665"),
            code: "AW",
            name: "Aruba",
            nameKey: "REFERENCE_DATA.COUNTRY.ARUBA"
        ),
        CountryModel(
            id: UUID(uuidString: "6D51F494-62E3-4B20-91E1-560FE1FD2599"),
            code: "AX",
            name: "Åland Islands",
            nameKey: "REFERENCE_DATA.COUNTRY.ALAND_ISLANDS"
        ),
        CountryModel(
            id: UUID(uuidString: "78D44133-A545-4BD9-AB75-A2B678B87664"),
            code: "AZ",
            name: "Azerbaijan",
            nameKey: "REFERENCE_DATA.COUNTRY.AZERBAIJAN"
        ),
        CountryModel(
            id: UUID(uuidString: "65423BA3-F12B-47A5-AA87-E64567F0AFB4"),
            code: "BA",
            name: "Bosnia & Herzegovina",
            nameKey: "REFERENCE_DATA.COUNTRY.BOSNIA_AND_HERZEGOVINA"
        ),
        CountryModel(
            id: UUID(uuidString: "56147FE7-5F04-4D5D-B75C-8FC7067E9382"),
            code: "BB",
            name: "Barbados",
            nameKey: "REFERENCE_DATA.COUNTRY.BARBADOS"
        ),
        CountryModel(
            id: UUID(uuidString: "8E66AEF7-3D5B-4050-82FC-990EF188C9DF"),
            code: "BD",
            name: "Bangladesh",
            nameKey: "REFERENCE_DATA.COUNTRY.BANGLADESH"
        ),
        CountryModel(
            id: UUID(uuidString: "06832D24-D55C-42D3-8830-B652CA0B2632"),
            code: "BE",
            name: "Belgium",
            nameKey: "REFERENCE_DATA.COUNTRY.BELGIUM"
        ),
        CountryModel(
            id: UUID(uuidString: "E317CA61-6C4E-4EC3-A64E-EE7E30CBA05C"),
            code: "BF",
            name: "Burkina Faso",
            nameKey: "REFERENCE_DATA.COUNTRY.BURKINA_FASO"
        ),
        CountryModel(
            id: UUID(uuidString: "71B2FFCD-9D1B-4D97-83A8-4EE4EDA1107C"),
            code: "BG",
            name: "Bulgaria",
            nameKey: "REFERENCE_DATA.COUNTRY.BULGARIA"
        ),
        CountryModel(
            id: UUID(uuidString: "812B6894-C161-422C-BF83-277920F6941A"),
            code: "BH",
            name: "Bahrain",
            nameKey: "REFERENCE_DATA.COUNTRY.BAHRAIN"
        ),
        CountryModel(
            id: UUID(uuidString: "374CB342-0D5A-4ADA-A292-3DA3DBDC27ED"),
            code: "BI",
            name: "Burundi",
            nameKey: "REFERENCE_DATA.COUNTRY.BURUNDI"
        ),
        CountryModel(
            id: UUID(uuidString: "73C2DAE9-4F3D-4D8A-9F36-1E3E09E20BF7"),
            code: "BJ",
            name: "Benin",
            nameKey: "REFERENCE_DATA.COUNTRY.BENIN"
        ),
        CountryModel(
            id: UUID(uuidString: "C6F9B7AD-535F-4DD4-9993-154563C22E7B"),
            code: "BL",
            name: "St Barthélemy",
            nameKey: "REFERENCE_DATA.COUNTRY.ST_BARTHELEMY"
        ),
        CountryModel(
            id: UUID(uuidString: "00EE477E-B32A-4DF5-A5E0-51364851D85C"),
            code: "BM",
            name: "Bermuda",
            nameKey: "REFERENCE_DATA.COUNTRY.BERMUDA"
        ),
        CountryModel(
            id: UUID(uuidString: "46AA1C01-C0DC-458E-A213-AB5F7CF1C64E"),
            code: "BN",
            name: "Brunei",
            nameKey: "REFERENCE_DATA.COUNTRY.BRUNEI"
        ),
        CountryModel(
            id: UUID(uuidString: "FAE13950-B251-4D98-B328-120265EBE830"),
            code: "BO",
            name: "Bolivia",
            nameKey: "REFERENCE_DATA.COUNTRY.BOLIVIA"
        ),
        CountryModel(
            id: UUID(uuidString: "FB708F07-8DD6-4C23-876C-47CC07B345ED"),
            code: "BQ",
            name: "Caribbean Netherlands",
            nameKey: "REFERENCE_DATA.COUNTRY.CARIBBEAN_NETHERLANDS"
        ),
        CountryModel(
            id: UUID(uuidString: "FBB38076-509A-4922-8B93-D77C88DD3F47"),
            code: "BR",
            name: "Brazil",
            nameKey: "REFERENCE_DATA.COUNTRY.BRAZIL"
        ),
        CountryModel(
            id: UUID(uuidString: "8E8B2535-701F-4E88-8FC5-A3595A384278"),
            code: "BS",
            name: "Bahamas",
            nameKey: "REFERENCE_DATA.COUNTRY.BAHAMAS"
        ),
        CountryModel(
            id: UUID(uuidString: "3F7C80A2-62AA-4B0C-A90B-C25330037D65"),
            code: "BT",
            name: "Bhutan",
            nameKey: "REFERENCE_DATA.COUNTRY.BHUTAN"
        ),
        CountryModel(
            id: UUID(uuidString: "AEFA8FD8-9E91-4D2E-938F-AB90606F17A9"),
            code: "BV",
            name: "Bouvet Island",
            nameKey: "REFERENCE_DATA.COUNTRY.BOUVET_ISLAND"
        ),
        CountryModel(
            id: UUID(uuidString: "80B1CA2F-E6F2-4B7D-B697-9EA3F7180DE9"),
            code: "BW",
            name: "Botswana",
            nameKey: "REFERENCE_DATA.COUNTRY.BOTSWANA"
        ),
        CountryModel(
            id: UUID(uuidString: "3B87E431-7872-4962-9CE4-9EE9C174DCED"),
            code: "BY",
            name: "Belarus",
            nameKey: "REFERENCE_DATA.COUNTRY.BELARUS"
        ),
        CountryModel(
            id: UUID(uuidString: "3C32D998-175A-47CF-B3D0-76C47FAD5B45"),
            code: "BZ",
            name: "Belize",
            nameKey: "REFERENCE_DATA.COUNTRY.BELIZE"
        ),
        CountryModel(
            id: UUID(uuidString: "27732ADF-F06B-4C37-B0D2-03891132A7BF"),
            code: "CA",
            name: "Canada",
            nameKey: "REFERENCE_DATA.COUNTRY.CANADA"
        ),
        CountryModel(
            id: UUID(uuidString: "9C501523-940A-4F73-8F8F-33F30981BFC3"),
            code: "CC",
            name: "Cocos (Keeling) Islands",
            nameKey: "REFERENCE_DATA.COUNTRY.COCOS_KEELING_ISLANDS"
        ),
        CountryModel(
            id: UUID(uuidString: "83FD9622-2212-4B22-9070-5A7258FD162F"),
            code: "CD",
            name: "Congo - Kinshasa",
            nameKey: "REFERENCE_DATA.COUNTRY.CONGO_KINSHASA"
        ),
        CountryModel(
            id: UUID(uuidString: "3AD513F6-8162-4F1C-AB0B-8D3C758898E9"),
            code: "CF",
            name: "Central African Republic",
            nameKey: "REFERENCE_DATA.COUNTRY.CENTRAL_AFRICAN_REPUBLIC"
        ),
        CountryModel(
            id: UUID(uuidString: "08B4BEFD-E6BA-48F6-90D5-55CFA473169F"),
            code: "CG",
            name: "Congo - Brazzaville",
            nameKey: "REFERENCE_DATA.COUNTRY.CONGO_BRAZZAVILLE"
        ),
        CountryModel(
            id: UUID(uuidString: "1DDCAA66-FBDD-44DB-B566-A12947FF2EE4"),
            code: "CH",
            name: "Switzerland",
            nameKey: "REFERENCE_DATA.COUNTRY.SWITZERLAND"
        ),
        CountryModel(
            id: UUID(uuidString: "51C3AD12-B763-4490-9A64-678851DEC37C"),
            code: "CI",
            name: "Côte d’Ivoire",
            nameKey: "REFERENCE_DATA.COUNTRY.COTE_D_IVOIRE"
        ),
        CountryModel(
            id: UUID(uuidString: "C69D3FE6-0A71-43EE-B59A-FA4292B78CAE"),
            code: "CK",
            name: "Cook Islands",
            nameKey: "REFERENCE_DATA.COUNTRY.COOK_ISLANDS"
        ),
        CountryModel(
            id: UUID(uuidString: "39938764-0A99-413B-8CE4-97B89B7448F4"),
            code: "CL",
            name: "Chile",
            nameKey: "REFERENCE_DATA.COUNTRY.CHILE"
        ),
        CountryModel(
            id: UUID(uuidString: "B9AD5063-584B-487D-BF04-97814D9DEC5D"),
            code: "CM",
            name: "Cameroon",
            nameKey: "REFERENCE_DATA.COUNTRY.CAMEROON"
        ),
        CountryModel(
            id: UUID(uuidString: "7610D341-6348-4E0F-B7E7-51883174BEB9"),
            code: "CN",
            name: "China mainland",
            nameKey: "REFERENCE_DATA.COUNTRY.CHINA_MAINLAND"
        ),
        CountryModel(
            id: UUID(uuidString: "EC4A64D8-BBC6-4956-A836-5F4B4E47AA91"),
            code: "CO",
            name: "Colombia",
            nameKey: "REFERENCE_DATA.COUNTRY.COLOMBIA"
        ),
        CountryModel(
            id: UUID(uuidString: "4A1093DA-FF29-448D-BA45-483E945F2DB2"),
            code: "CP",
            name: "Clipperton Island",
            nameKey: "REFERENCE_DATA.COUNTRY.CLIPPERTON_ISLAND"
        ),
        CountryModel(
            id: UUID(uuidString: "0E1B4497-7E0F-4530-B8A8-35487DD6B185"),
            code: "CQ",
            name: "Sark",
            nameKey: "REFERENCE_DATA.COUNTRY.SARK"
        ),
        CountryModel(
            id: UUID(uuidString: "B8BE5267-99E2-4E87-9870-7122EAC2F6B2"),
            code: "CR",
            name: "Costa Rica",
            nameKey: "REFERENCE_DATA.COUNTRY.COSTA_RICA"
        ),
        CountryModel(
            id: UUID(uuidString: "A817F120-4995-4D6D-8C1E-761D9F3DB447"),
            code: "CU",
            name: "Cuba",
            nameKey: "REFERENCE_DATA.COUNTRY.CUBA"
        ),
        CountryModel(
            id: UUID(uuidString: "87FC5D58-B2E6-429C-8DF9-912D50C5CA36"),
            code: "CV",
            name: "Cape Verde",
            nameKey: "REFERENCE_DATA.COUNTRY.CAPE_VERDE"
        ),
        CountryModel(
            id: UUID(uuidString: "0FD7CD5E-DEA2-443B-A827-A1983B6FB920"),
            code: "CW",
            name: "Curaçao",
            nameKey: "REFERENCE_DATA.COUNTRY.CURACAO"
        ),
        CountryModel(
            id: UUID(uuidString: "17C039C6-7EF1-4A1D-A7CA-6FDC0B4582E3"),
            code: "CX",
            name: "Christmas Island",
            nameKey: "REFERENCE_DATA.COUNTRY.CHRISTMAS_ISLAND"
        ),
        CountryModel(
            id: UUID(uuidString: "4B381736-9EA1-4BDC-8D26-BABCD6F0CF45"),
            code: "CY",
            name: "Cyprus",
            nameKey: "REFERENCE_DATA.COUNTRY.CYPRUS"
        ),
        CountryModel(
            id: UUID(uuidString: "A4D4FD4D-04FC-4DC5-8B97-1CCC6C71A08E"),
            code: "CZ",
            name: "Czechia",
            nameKey: "REFERENCE_DATA.COUNTRY.CZECHIA"
        ),
        CountryModel(
            id: UUID(uuidString: "1FE969E5-A880-4B32-928B-0944F284B747"),
            code: "DE",
            name: "Germany",
            nameKey: "REFERENCE_DATA.COUNTRY.GERMANY"
        ),
        CountryModel(
            id: UUID(uuidString: "C54E934A-EC1F-4BF2-AE66-50CD16293155"),
            code: "DG",
            name: "Diego Garcia",
            nameKey: "REFERENCE_DATA.COUNTRY.DIEGO_GARCIA"
        ),
        CountryModel(
            id: UUID(uuidString: "CFB47B26-D269-4971-938A-602798ABDDFB"),
            code: "DJ",
            name: "Djibouti",
            nameKey: "REFERENCE_DATA.COUNTRY.DJIBOUTI"
        ),
        CountryModel(
            id: UUID(uuidString: "49E5642C-5A49-4A3F-9D6A-A0F91CD2B0B6"),
            code: "DK",
            name: "Denmark",
            nameKey: "REFERENCE_DATA.COUNTRY.DENMARK"
        ),
        CountryModel(
            id: UUID(uuidString: "77339EF6-D8AD-46B6-8637-FC80BB159A50"),
            code: "DM",
            name: "Dominica",
            nameKey: "REFERENCE_DATA.COUNTRY.DOMINICA"
        ),
        CountryModel(
            id: UUID(uuidString: "696914B2-051C-4ACD-BC1B-F11060F64C40"),
            code: "DO",
            name: "Dominican Republic",
            nameKey: "REFERENCE_DATA.COUNTRY.DOMINICAN_REPUBLIC"
        ),
        CountryModel(
            id: UUID(uuidString: "09E06D9F-B64E-42AB-AB63-404DEBB8649A"),
            code: "DZ",
            name: "Algeria",
            nameKey: "REFERENCE_DATA.COUNTRY.ALGERIA"
        ),
        CountryModel(
            id: UUID(uuidString: "018723F6-1685-42F4-99E5-40D3466D9986"),
            code: "EA",
            name: "Ceuta & Melilla",
            nameKey: "REFERENCE_DATA.COUNTRY.CEUTA_AND_MELILLA"
        ),
        CountryModel(
            id: UUID(uuidString: "37869CFF-807F-42EC-83AC-3243C614AA59"),
            code: "EC",
            name: "Ecuador",
            nameKey: "REFERENCE_DATA.COUNTRY.ECUADOR"
        ),
        CountryModel(
            id: UUID(uuidString: "0A5C4DCB-D6D5-4604-AE41-EC18F0E5DE57"),
            code: "EE",
            name: "Estonia",
            nameKey: "REFERENCE_DATA.COUNTRY.ESTONIA"
        ),
        CountryModel(
            id: UUID(uuidString: "654B05BE-B56A-4AD5-A9FA-03C33744CCEE"),
            code: "EG",
            name: "Egypt",
            nameKey: "REFERENCE_DATA.COUNTRY.EGYPT"
        ),
        CountryModel(
            id: UUID(uuidString: "1A1B8706-EFA0-4F41-BECA-D459D39209B7"),
            code: "EH",
            name: "Western Sahara",
            nameKey: "REFERENCE_DATA.COUNTRY.WESTERN_SAHARA"
        ),
        CountryModel(
            id: UUID(uuidString: "38D12A49-08DF-4BEF-9DEF-102748219E6F"),
            code: "ER",
            name: "Eritrea",
            nameKey: "REFERENCE_DATA.COUNTRY.ERITREA"
        ),
        CountryModel(
            id: UUID(uuidString: "2D8D57D9-570B-464C-99BE-3479AB68EF01"),
            code: "ES",
            name: "Spain",
            nameKey: "REFERENCE_DATA.COUNTRY.SPAIN"
        ),
        CountryModel(
            id: UUID(uuidString: "DE966FB9-2C6D-422C-8127-F5EDE533FCFA"),
            code: "ET",
            name: "Ethiopia",
            nameKey: "REFERENCE_DATA.COUNTRY.ETHIOPIA"
        ),
        CountryModel(
            id: UUID(uuidString: "C7DC1427-201C-4039-8089-531BF5F20BF3"),
            code: "FI",
            name: "Finland",
            nameKey: "REFERENCE_DATA.COUNTRY.FINLAND"
        ),
        CountryModel(
            id: UUID(uuidString: "6358E95B-8AC1-4506-B331-65DBC475F56D"),
            code: "FJ",
            name: "Fiji",
            nameKey: "REFERENCE_DATA.COUNTRY.FIJI"
        ),
        CountryModel(
            id: UUID(uuidString: "A35FDFA5-7B7F-4AC8-95CE-640D048E864C"),
            code: "FK",
            name: "Falkland Islands",
            nameKey: "REFERENCE_DATA.COUNTRY.FALKLAND_ISLANDS"
        ),
        CountryModel(
            id: UUID(uuidString: "C75EB5DC-D46C-4966-8216-1CFE3645E634"),
            code: "FM",
            name: "Micronesia",
            nameKey: "REFERENCE_DATA.COUNTRY.MICRONESIA"
        ),
        CountryModel(
            id: UUID(uuidString: "2A4E2C39-3FD4-4E57-A589-B2F6D76D02C0"),
            code: "FO",
            name: "Faroe Islands",
            nameKey: "REFERENCE_DATA.COUNTRY.FAROE_ISLANDS"
        ),
        CountryModel(
            id: UUID(uuidString: "E8026112-8E16-4BEC-99EA-742D1508BAC1"),
            code: "FR",
            name: "France",
            nameKey: "REFERENCE_DATA.COUNTRY.FRANCE"
        ),
        CountryModel(
            id: UUID(uuidString: "391FFFA3-A291-49F5-8B1F-6F95132DDAE2"),
            code: "GA",
            name: "Gabon",
            nameKey: "REFERENCE_DATA.COUNTRY.GABON"
        ),
        CountryModel(
            id: UUID(uuidString: "698DD1A8-B827-4511-930A-C6854C6A4948"),
            code: "GB",
            name: "United Kingdom",
            nameKey: "REFERENCE_DATA.COUNTRY.UNITED_KINGDOM"
        ),
        CountryModel(
            id: UUID(uuidString: "B76CA53D-593E-4FAD-A593-93C5AE1F1934"),
            code: "GD",
            name: "Grenada",
            nameKey: "REFERENCE_DATA.COUNTRY.GRENADA"
        ),
        CountryModel(
            id: UUID(uuidString: "9743B9CF-A1DB-4AF5-BA3B-C335AECC563F"),
            code: "GE",
            name: "Georgia",
            nameKey: "REFERENCE_DATA.COUNTRY.GEORGIA"
        ),
        CountryModel(
            id: UUID(uuidString: "68340319-9B24-4BF7-ACBD-AEEBB8E0E9BE"),
            code: "GF",
            name: "French Guiana",
            nameKey: "REFERENCE_DATA.COUNTRY.FRENCH_GUIANA"
        ),
        CountryModel(
            id: UUID(uuidString: "4C3D1174-759E-4913-85F8-E62DB4A2AE80"),
            code: "GG",
            name: "Guernsey",
            nameKey: "REFERENCE_DATA.COUNTRY.GUERNSEY"
        ),
        CountryModel(
            id: UUID(uuidString: "BD401367-0F66-4C75-A01E-80E77A73D54D"),
            code: "GH",
            name: "Ghana",
            nameKey: "REFERENCE_DATA.COUNTRY.GHANA"
        ),
        CountryModel(
            id: UUID(uuidString: "FD6515FB-3267-4D48-ADBE-1B287A61FD27"),
            code: "GI",
            name: "Gibraltar",
            nameKey: "REFERENCE_DATA.COUNTRY.GIBRALTAR"
        ),
        CountryModel(
            id: UUID(uuidString: "0BC1A671-5B05-46D7-9628-03E5B60A5A66"),
            code: "GL",
            name: "Greenland",
            nameKey: "REFERENCE_DATA.COUNTRY.GREENLAND"
        ),
        CountryModel(
            id: UUID(uuidString: "D56520D2-CFC9-48AD-B59E-097D3F0EBFB1"),
            code: "GM",
            name: "Gambia",
            nameKey: "REFERENCE_DATA.COUNTRY.GAMBIA"
        ),
        CountryModel(
            id: UUID(uuidString: "7D65642A-6642-4F61-9C0A-B29FA5E0B920"),
            code: "GN",
            name: "Guinea",
            nameKey: "REFERENCE_DATA.COUNTRY.GUINEA"
        ),
        CountryModel(
            id: UUID(uuidString: "66A4077C-A8EF-4077-A545-8885ED73C850"),
            code: "GP",
            name: "Guadeloupe",
            nameKey: "REFERENCE_DATA.COUNTRY.GUADELOUPE"
        ),
        CountryModel(
            id: UUID(uuidString: "8510ABCF-9013-4B09-8B19-E93EE53F68D5"),
            code: "GQ",
            name: "Equatorial Guinea",
            nameKey: "REFERENCE_DATA.COUNTRY.EQUATORIAL_GUINEA"
        ),
        CountryModel(
            id: UUID(uuidString: "F76CC40A-273E-49B7-BA1B-FBD1484170D2"),
            code: "GR",
            name: "Greece",
            nameKey: "REFERENCE_DATA.COUNTRY.GREECE"
        ),
        CountryModel(
            id: UUID(uuidString: "9DE159CC-F114-48C0-B1ED-A307516AAC50"),
            code: "GS",
            name: "So. Georgia & So. Sandwich Isl.",
            nameKey: "REFERENCE_DATA.COUNTRY.SO_GEORGIA_AND_SO_SANDWICH_ISL"
        ),
        CountryModel(
            id: UUID(uuidString: "A1F2F3F0-D0AE-49F6-AF80-F801D28E6A95"),
            code: "GT",
            name: "Guatemala",
            nameKey: "REFERENCE_DATA.COUNTRY.GUATEMALA"
        ),
        CountryModel(
            id: UUID(uuidString: "076AC54A-FE66-4CEB-8FBA-FF851B969C28"),
            code: "GU",
            name: "Guam",
            nameKey: "REFERENCE_DATA.COUNTRY.GUAM"
        ),
        CountryModel(
            id: UUID(uuidString: "E18A010F-D23F-42E6-BB5E-C52A5E8DF9EC"),
            code: "GW",
            name: "Guinea-Bissau",
            nameKey: "REFERENCE_DATA.COUNTRY.GUINEA_BISSAU"
        ),
        CountryModel(
            id: UUID(uuidString: "011AE38B-C878-4918-86F4-F4A34DA601C1"),
            code: "GY",
            name: "Guyana",
            nameKey: "REFERENCE_DATA.COUNTRY.GUYANA"
        ),
        CountryModel(
            id: UUID(uuidString: "9B7EE827-5A11-4BE4-A5DA-A1D7EE08F48B"),
            code: "HK",
            name: "Hong Kong",
            nameKey: "REFERENCE_DATA.COUNTRY.HONG_KONG"
        ),
        CountryModel(
            id: UUID(uuidString: "3F8D3C88-C5B0-4043-BBE4-5C359C3E7AF4"),
            code: "HM",
            name: "Heard & McDonald Islands",
            nameKey: "REFERENCE_DATA.COUNTRY.HEARD_AND_MCDONALD_ISLANDS"
        ),
        CountryModel(
            id: UUID(uuidString: "F1FABCE8-55DA-40EB-A3BB-C3D740AAB8DF"),
            code: "HN",
            name: "Honduras",
            nameKey: "REFERENCE_DATA.COUNTRY.HONDURAS"
        ),
        CountryModel(
            id: UUID(uuidString: "4DEEEBFB-C70C-461C-BEAD-4D07D0FE4EF0"),
            code: "HR",
            name: "Croatia",
            nameKey: "REFERENCE_DATA.COUNTRY.CROATIA"
        ),
        CountryModel(
            id: UUID(uuidString: "3AC486C0-8EE6-4021-8E4E-E565AB34029E"),
            code: "HT",
            name: "Haiti",
            nameKey: "REFERENCE_DATA.COUNTRY.HAITI"
        ),
        CountryModel(
            id: UUID(uuidString: "5FA5381A-160F-427B-A6BD-A4EAF50A09E8"),
            code: "HU",
            name: "Hungary",
            nameKey: "REFERENCE_DATA.COUNTRY.HUNGARY"
        ),
        CountryModel(
            id: UUID(uuidString: "278FDAAA-C3BC-402A-9854-E21D5E152AC7"),
            code: "IC",
            name: "Canary Islands",
            nameKey: "REFERENCE_DATA.COUNTRY.CANARY_ISLANDS"
        ),
        CountryModel(
            id: UUID(uuidString: "A0164616-FE01-4C3C-A9D6-69324EBD3C20"),
            code: "ID",
            name: "Indonesia",
            nameKey: "REFERENCE_DATA.COUNTRY.INDONESIA"
        ),
        CountryModel(
            id: UUID(uuidString: "CBE86CBE-BB4A-4426-8E5D-EB9FB08DB882"),
            code: "IE",
            name: "Ireland",
            nameKey: "REFERENCE_DATA.COUNTRY.IRELAND"
        ),
        CountryModel(
            id: UUID(uuidString: "90E4C8A2-69A2-4002-AEF3-D9E6C58F9B02"),
            code: "IL",
            name: "Israel",
            nameKey: "REFERENCE_DATA.COUNTRY.ISRAEL"
        ),
        CountryModel(
            id: UUID(uuidString: "0F22C3E4-BEC5-4794-8E68-8F3983AC72FC"),
            code: "IM",
            name: "Isle of Man",
            nameKey: "REFERENCE_DATA.COUNTRY.ISLE_OF_MAN"
        ),
        CountryModel(
            id: UUID(uuidString: "B4DC03F6-AFAE-47E7-8344-0F8641614C53"),
            code: "IN",
            name: "India",
            nameKey: "REFERENCE_DATA.COUNTRY.INDIA"
        ),
        CountryModel(
            id: UUID(uuidString: "E323EE77-F8B3-4CB3-91FF-501E1B426C74"),
            code: "IO",
            name: "Chagos Archipelago",
            nameKey: "REFERENCE_DATA.COUNTRY.CHAGOS_ARCHIPELAGO"
        ),
        CountryModel(
            id: UUID(uuidString: "0F988DF5-8516-4722-959C-CC63CB7141A8"),
            code: "IQ",
            name: "Iraq",
            nameKey: "REFERENCE_DATA.COUNTRY.IRAQ"
        ),
        CountryModel(
            id: UUID(uuidString: "FF88857D-4E3E-4B2A-A887-F80886774B68"),
            code: "IR",
            name: "Iran",
            nameKey: "REFERENCE_DATA.COUNTRY.IRAN"
        ),
        CountryModel(
            id: UUID(uuidString: "1CCEB4DF-CE35-4ADD-82C3-A8FE360B1883"),
            code: "IS",
            name: "Iceland",
            nameKey: "REFERENCE_DATA.COUNTRY.ICELAND"
        ),
        CountryModel(
            id: UUID(uuidString: "56E303B4-72F0-4CF9-892F-F44A5C6D0AB0"),
            code: "IT",
            name: "Italy",
            nameKey: "REFERENCE_DATA.COUNTRY.ITALY"
        ),
        CountryModel(
            id: UUID(uuidString: "2C34B81D-3E4B-4FFF-8C01-DAC29CBC5027"),
            code: "JE",
            name: "Jersey",
            nameKey: "REFERENCE_DATA.COUNTRY.JERSEY"
        ),
        CountryModel(
            id: UUID(uuidString: "5F05C27A-E4CB-449D-83E9-291E1305899A"),
            code: "JM",
            name: "Jamaica",
            nameKey: "REFERENCE_DATA.COUNTRY.JAMAICA"
        ),
        CountryModel(
            id: UUID(uuidString: "22BF6EE1-071F-46BE-9985-5DCF6184BFA8"),
            code: "JO",
            name: "Jordan",
            nameKey: "REFERENCE_DATA.COUNTRY.JORDAN"
        ),
        CountryModel(
            id: UUID(uuidString: "68693CE7-5305-480D-ADC0-242D6F563654"),
            code: "JP",
            name: "Japan",
            nameKey: "REFERENCE_DATA.COUNTRY.JAPAN"
        ),
        CountryModel(
            id: UUID(uuidString: "AAB8293F-B38C-4566-BA6D-D297A4DB1F19"),
            code: "KE",
            name: "Kenya",
            nameKey: "REFERENCE_DATA.COUNTRY.KENYA"
        ),
        CountryModel(
            id: UUID(uuidString: "571BE5F8-DA2C-4AD4-9EA2-E0D29BDAF2F3"),
            code: "KG",
            name: "Kyrgyzstan",
            nameKey: "REFERENCE_DATA.COUNTRY.KYRGYZSTAN"
        ),
        CountryModel(
            id: UUID(uuidString: "5E11FB55-577A-473C-8143-BD4C4CA4D9FC"),
            code: "KH",
            name: "Cambodia",
            nameKey: "REFERENCE_DATA.COUNTRY.CAMBODIA"
        ),
        CountryModel(
            id: UUID(uuidString: "251EB1F3-B6F0-4408-8135-90C5C50108E5"),
            code: "KI",
            name: "Kiribati",
            nameKey: "REFERENCE_DATA.COUNTRY.KIRIBATI"
        ),
        CountryModel(
            id: UUID(uuidString: "DAE6FCEB-E4A2-4946-A316-50159B74D6F9"),
            code: "KM",
            name: "Comoros",
            nameKey: "REFERENCE_DATA.COUNTRY.COMOROS"
        ),
        CountryModel(
            id: UUID(uuidString: "0E04390D-42E5-4D81-A019-9AA9D826763F"),
            code: "KN",
            name: "St Kitts & Nevis",
            nameKey: "REFERENCE_DATA.COUNTRY.ST_KITTS_AND_NEVIS"
        ),
        CountryModel(
            id: UUID(uuidString: "DD7D93E0-F194-4094-815E-0A8A7B47D553"),
            code: "KP",
            name: "North Korea",
            nameKey: "REFERENCE_DATA.COUNTRY.NORTH_KOREA"
        ),
        CountryModel(
            id: UUID(uuidString: "AFCF6573-A2E5-4909-A686-2D5756AD7C8C"),
            code: "KR",
            name: "South Korea",
            nameKey: "REFERENCE_DATA.COUNTRY.SOUTH_KOREA"
        ),
        CountryModel(
            id: UUID(uuidString: "50CBC822-CF62-471F-BB07-9895DB8F4156"),
            code: "KW",
            name: "Kuwait",
            nameKey: "REFERENCE_DATA.COUNTRY.KUWAIT"
        ),
        CountryModel(
            id: UUID(uuidString: "36775B5B-A762-46E0-B498-E6028823A7F6"),
            code: "KY",
            name: "Cayman Islands",
            nameKey: "REFERENCE_DATA.COUNTRY.CAYMAN_ISLANDS"
        ),
        CountryModel(
            id: UUID(uuidString: "8F589B34-7E68-4221-AB08-FB0FF87EAA4F"),
            code: "KZ",
            name: "Kazakhstan",
            nameKey: "REFERENCE_DATA.COUNTRY.KAZAKHSTAN"
        ),
        CountryModel(
            id: UUID(uuidString: "DDFBBB83-1714-44D4-B0ED-1869F33F808C"),
            code: "LA",
            name: "Laos",
            nameKey: "REFERENCE_DATA.COUNTRY.LAOS"
        ),
        CountryModel(
            id: UUID(uuidString: "3D908E5B-0B1A-4C8B-A97A-629235C8A163"),
            code: "LB",
            name: "Lebanon",
            nameKey: "REFERENCE_DATA.COUNTRY.LEBANON"
        ),
        CountryModel(
            id: UUID(uuidString: "5AC39EA5-BC55-4A42-9069-626AEDF1F643"),
            code: "LC",
            name: "St Lucia",
            nameKey: "REFERENCE_DATA.COUNTRY.ST_LUCIA"
        ),
        CountryModel(
            id: UUID(uuidString: "75D5A1C7-E2E0-4B0D-80C6-73B36B095D9F"),
            code: "LI",
            name: "Liechtenstein",
            nameKey: "REFERENCE_DATA.COUNTRY.LIECHTENSTEIN"
        ),
        CountryModel(
            id: UUID(uuidString: "56EF3143-A30C-4B63-9E0C-0A6E41885826"),
            code: "LK",
            name: "Sri Lanka",
            nameKey: "REFERENCE_DATA.COUNTRY.SRI_LANKA"
        ),
        CountryModel(
            id: UUID(uuidString: "B654BF81-B124-4A5E-AAFF-3A016FC34862"),
            code: "LR",
            name: "Liberia",
            nameKey: "REFERENCE_DATA.COUNTRY.LIBERIA"
        ),
        CountryModel(
            id: UUID(uuidString: "8FD0DF3D-15DF-44FD-8FE2-05E1AA0DA23D"),
            code: "LS",
            name: "Lesotho",
            nameKey: "REFERENCE_DATA.COUNTRY.LESOTHO"
        ),
        CountryModel(
            id: UUID(uuidString: "4FA207B6-7A07-4BFA-AB00-4E4D45193F7E"),
            code: "LT",
            name: "Lithuania",
            nameKey: "REFERENCE_DATA.COUNTRY.LITHUANIA"
        ),
        CountryModel(
            id: UUID(uuidString: "CDF638E8-44B5-4C33-B5AB-33A1486CDE43"),
            code: "LU",
            name: "Luxembourg",
            nameKey: "REFERENCE_DATA.COUNTRY.LUXEMBOURG"
        ),
        CountryModel(
            id: UUID(uuidString: "2B25376E-79BC-47F7-806F-9BA94E0B2023"),
            code: "LV",
            name: "Latvia",
            nameKey: "REFERENCE_DATA.COUNTRY.LATVIA"
        ),
        CountryModel(
            id: UUID(uuidString: "90153FAA-F79A-4538-9769-CCF34AE71CF1"),
            code: "LY",
            name: "Libya",
            nameKey: "REFERENCE_DATA.COUNTRY.LIBYA"
        ),
        CountryModel(
            id: UUID(uuidString: "A6AE118F-9EB9-4627-BE52-3532C5EF54C4"),
            code: "MA",
            name: "Morocco",
            nameKey: "REFERENCE_DATA.COUNTRY.MOROCCO"
        ),
        CountryModel(
            id: UUID(uuidString: "DD37F0F2-452C-47B1-B584-9978537689D6"),
            code: "MC",
            name: "Monaco",
            nameKey: "REFERENCE_DATA.COUNTRY.MONACO"
        ),
        CountryModel(
            id: UUID(uuidString: "FC64EF14-DDE7-4FFB-BDF7-C039CB8D0A06"),
            code: "MD",
            name: "Moldova",
            nameKey: "REFERENCE_DATA.COUNTRY.MOLDOVA"
        ),
        CountryModel(
            id: UUID(uuidString: "C1FCC3E5-C573-4976-A81F-FBA3D7137245"),
            code: "ME",
            name: "Montenegro",
            nameKey: "REFERENCE_DATA.COUNTRY.MONTENEGRO"
        ),
        CountryModel(
            id: UUID(uuidString: "A4680684-5636-44D5-8E5A-A454D902D044"),
            code: "MF",
            name: "St Martin",
            nameKey: "REFERENCE_DATA.COUNTRY.ST_MARTIN"
        ),
        CountryModel(
            id: UUID(uuidString: "3B577E23-A383-408D-A07F-3DFFFAB5C31D"),
            code: "MG",
            name: "Madagascar",
            nameKey: "REFERENCE_DATA.COUNTRY.MADAGASCAR"
        ),
        CountryModel(
            id: UUID(uuidString: "7D18C481-D0A3-46C9-9D4B-E7ACD7683502"),
            code: "MH",
            name: "Marshall Islands",
            nameKey: "REFERENCE_DATA.COUNTRY.MARSHALL_ISLANDS"
        ),
        CountryModel(
            id: UUID(uuidString: "99E205BA-B075-4840-9BC7-259F23000B00"),
            code: "MK",
            name: "North Macedonia",
            nameKey: "REFERENCE_DATA.COUNTRY.NORTH_MACEDONIA"
        ),
        CountryModel(
            id: UUID(uuidString: "34748E62-3230-43B7-BF78-C879EE94DDEF"),
            code: "ML",
            name: "Mali",
            nameKey: "REFERENCE_DATA.COUNTRY.MALI"
        ),
        CountryModel(
            id: UUID(uuidString: "E31A8296-A156-471C-9353-10C349CBF737"),
            code: "MM",
            name: "Myanmar (Burma)",
            nameKey: "REFERENCE_DATA.COUNTRY.MYANMAR"
        ),
        CountryModel(
            id: UUID(uuidString: "41AA899E-82DF-4AF8-A06C-F744B2B93C28"),
            code: "MN",
            name: "Mongolia",
            nameKey: "REFERENCE_DATA.COUNTRY.MONGOLIA"
        ),
        CountryModel(
            id: UUID(uuidString: "12847F4B-DB5E-4BAF-B1B3-DC39E1E84C62"),
            code: "MO",
            name: "Macao",
            nameKey: "REFERENCE_DATA.COUNTRY.MACAO"
        ),
        CountryModel(
            id: UUID(uuidString: "A83AA7EF-2B34-414D-96C0-FD402F5AAC86"),
            code: "MP",
            name: "Northern Mariana Islands",
            nameKey: "REFERENCE_DATA.COUNTRY.NORTHERN_MARIANA_ISLANDS"
        ),
        CountryModel(
            id: UUID(uuidString: "B539AF8B-12F2-4277-B6D4-B97624A6CE21"),
            code: "MQ",
            name: "Martinique",
            nameKey: "REFERENCE_DATA.COUNTRY.MARTINIQUE"
        ),
        CountryModel(
            id: UUID(uuidString: "47341800-D2A1-4610-9CD7-009594BA005D"),
            code: "MR",
            name: "Mauritania",
            nameKey: "REFERENCE_DATA.COUNTRY.MAURITANIA"
        ),
        CountryModel(
            id: UUID(uuidString: "1B86FE55-183C-4BCF-8382-6E8F63B382A3"),
            code: "MS",
            name: "Montserrat",
            nameKey: "REFERENCE_DATA.COUNTRY.MONTSERRAT"
        ),
        CountryModel(
            id: UUID(uuidString: "12B4C4B5-2F81-4544-A023-9EC4BBFE01BD"),
            code: "MT",
            name: "Malta",
            nameKey: "REFERENCE_DATA.COUNTRY.MALTA"
        ),
        CountryModel(
            id: UUID(uuidString: "3CE34FBE-1393-4F82-996C-E8AF8C584D0F"),
            code: "MU",
            name: "Mauritius",
            nameKey: "REFERENCE_DATA.COUNTRY.MAURITIUS"
        ),
        CountryModel(
            id: UUID(uuidString: "0CBFEB1B-F39B-4BC1-84D2-219939983BA9"),
            code: "MV",
            name: "Maldives",
            nameKey: "REFERENCE_DATA.COUNTRY.MALDIVES"
        ),
        CountryModel(
            id: UUID(uuidString: "443F08BE-7624-4CA9-8CA7-8704B92DABB4"),
            code: "MW",
            name: "Malawi",
            nameKey: "REFERENCE_DATA.COUNTRY.MALAWI"
        ),
        CountryModel(
            id: UUID(uuidString: "4B256DC9-5EF8-4465-80AB-F1D0DC3AF7A5"),
            code: "MX",
            name: "Mexico",
            nameKey: "REFERENCE_DATA.COUNTRY.MEXICO"
        ),
        CountryModel(
            id: UUID(uuidString: "539C549D-C020-4CB3-9EED-01767B3860E9"),
            code: "MY",
            name: "Malaysia",
            nameKey: "REFERENCE_DATA.COUNTRY.MALAYSIA"
        ),
        CountryModel(
            id: UUID(uuidString: "17FB9DD0-F94F-4F8B-B3D9-06D9636C1096"),
            code: "MZ",
            name: "Mozambique",
            nameKey: "REFERENCE_DATA.COUNTRY.MOZAMBIQUE"
        ),
        CountryModel(
            id: UUID(uuidString: "9FA7D622-1391-4706-BE0E-33A2B63AFE53"),
            code: "NA",
            name: "Namibia",
            nameKey: "REFERENCE_DATA.COUNTRY.NAMIBIA"
        ),
        CountryModel(
            id: UUID(uuidString: "C84EF669-17C2-41EE-9F8D-318DCF6C89B4"),
            code: "NC",
            name: "New Caledonia",
            nameKey: "REFERENCE_DATA.COUNTRY.NEW_CALEDONIA"
        ),
        CountryModel(
            id: UUID(uuidString: "6FCFE4DF-2764-4B1A-84B2-ABAB0917C4AF"),
            code: "NE",
            name: "Niger",
            nameKey: "REFERENCE_DATA.COUNTRY.NIGER"
        ),
        CountryModel(
            id: UUID(uuidString: "8D728F6E-71DB-4D22-9094-2EBEFE44B28D"),
            code: "NF",
            name: "Norfolk Island",
            nameKey: "REFERENCE_DATA.COUNTRY.NORFOLK_ISLAND"
        ),
        CountryModel(
            id: UUID(uuidString: "96A11B7B-A51A-46FE-A0A5-28BCBF2D2B80"),
            code: "NG",
            name: "Nigeria",
            nameKey: "REFERENCE_DATA.COUNTRY.NIGERIA"
        ),
        CountryModel(
            id: UUID(uuidString: "EE0EE722-2A56-484E-8AF8-7AF0C60AE634"),
            code: "NI",
            name: "Nicaragua",
            nameKey: "REFERENCE_DATA.COUNTRY.NICARAGUA"
        ),
        CountryModel(
            id: UUID(uuidString: "99B785DA-393B-4111-B49D-F990CE8722ED"),
            code: "NL",
            name: "Netherlands",
            nameKey: "REFERENCE_DATA.COUNTRY.NETHERLANDS"
        ),
        CountryModel(
            id: UUID(uuidString: "5D1C97C9-A9BB-4A3A-B90C-DE1CF1C2F1F8"),
            code: "NO",
            name: "Norway",
            nameKey: "REFERENCE_DATA.COUNTRY.NORWAY"
        ),
        CountryModel(
            id: UUID(uuidString: "DD575E3F-1F57-4E4D-95AF-FC9957A74749"),
            code: "NP",
            name: "Nepal",
            nameKey: "REFERENCE_DATA.COUNTRY.NEPAL"
        ),
        CountryModel(
            id: UUID(uuidString: "DF5E27D0-C2EA-4ACF-9593-814D75BBE013"),
            code: "NR",
            name: "Nauru",
            nameKey: "REFERENCE_DATA.COUNTRY.NAURU"
        ),
        CountryModel(
            id: UUID(uuidString: "752036AF-CDA6-4A8C-826B-7813AA9F805E"),
            code: "NU",
            name: "Niue",
            nameKey: "REFERENCE_DATA.COUNTRY.NIUE"
        ),
        CountryModel(
            id: UUID(uuidString: "E7D9532C-C1BE-47F3-855A-A0F1BF7EF575"),
            code: "NZ",
            name: "New Zealand",
            nameKey: "REFERENCE_DATA.COUNTRY.NEW_ZEALAND"
        ),
        CountryModel(
            id: UUID(uuidString: "BBB21AA7-6C08-46F4-8E6A-5313B4C1A903"),
            code: "OM",
            name: "Oman",
            nameKey: "REFERENCE_DATA.COUNTRY.OMAN"
        ),
        CountryModel(
            id: UUID(uuidString: "1E4BFE43-A800-4E9C-B33A-F6842CB7633D"),
            code: "PA",
            name: "Panama",
            nameKey: "REFERENCE_DATA.COUNTRY.PANAMA"
        ),
        CountryModel(
            id: UUID(uuidString: "A1DDC8DC-16A0-4CBA-BD3D-B08ABD9699D8"),
            code: "PE",
            name: "Peru",
            nameKey: "REFERENCE_DATA.COUNTRY.PERU"
        ),
        CountryModel(
            id: UUID(uuidString: "95960D68-749F-46BC-A153-F8349650087B"),
            code: "PF",
            name: "French Polynesia",
            nameKey: "REFERENCE_DATA.COUNTRY.FRENCH_POLYNESIA"
        ),
        CountryModel(
            id: UUID(uuidString: "B2B1A31D-F93C-4BD3-9852-1D10F3278900"),
            code: "PG",
            name: "Papua New Guinea",
            nameKey: "REFERENCE_DATA.COUNTRY.PAPUA_NEW_GUINEA"
        ),
        CountryModel(
            id: UUID(uuidString: "9B5047B2-3193-44A6-89A1-CF0D40C1E500"),
            code: "PH",
            name: "Philippines",
            nameKey: "REFERENCE_DATA.COUNTRY.PHILIPPINES"
        ),
        CountryModel(
            id: UUID(uuidString: "BBDCCC4D-6D40-4225-BA7F-89CDDB4768FD"),
            code: "PK",
            name: "Pakistan",
            nameKey: "REFERENCE_DATA.COUNTRY.PAKISTAN"
        ),
        CountryModel(
            id: UUID(uuidString: "0AA2F570-CEFA-46A9-9F4C-03AAEFFF2872"),
            code: "PL",
            name: "Poland",
            nameKey: "REFERENCE_DATA.COUNTRY.POLAND"
        ),
        CountryModel(
            id: UUID(uuidString: "013AB8E9-5693-4570-ACD8-140E46C04E30"),
            code: "PM",
            name: "St Pierre & Miquelon",
            nameKey: "REFERENCE_DATA.COUNTRY.ST_PIERRE_AND_MIQUELON"
        ),
        CountryModel(
            id: UUID(uuidString: "15978508-CE24-4836-8143-BD0196533F9B"),
            code: "PN",
            name: "Pitcairn Islands",
            nameKey: "REFERENCE_DATA.COUNTRY.PITCAIRN_ISLANDS"
        ),
        CountryModel(
            id: UUID(uuidString: "ACDDE5CD-22C2-4733-A8CC-6E593F1B246C"),
            code: "PR",
            name: "Puerto Rico",
            nameKey: "REFERENCE_DATA.COUNTRY.PUERTO_RICO"
        ),
        CountryModel(
            id: UUID(uuidString: "429C0EDB-FC51-45B2-AAF7-805FA14B78F9"),
            code: "PS",
            name: "Palestinian Territories",
            nameKey: "REFERENCE_DATA.COUNTRY.PALESTINIAN_TERRITORIES"
        ),
        CountryModel(
            id: UUID(uuidString: "D86011CE-13C0-458A-B105-0F536F6405F1"),
            code: "PT",
            name: "Portugal",
            nameKey: "REFERENCE_DATA.COUNTRY.PORTUGAL"
        ),
        CountryModel(
            id: UUID(uuidString: "844CF01B-2424-44D7-A52A-6EEC951144EE"),
            code: "PW",
            name: "Palau",
            nameKey: "REFERENCE_DATA.COUNTRY.PALAU"
        ),
        CountryModel(
            id: UUID(uuidString: "CBE96A62-C9F1-4184-AAA6-C03B6B3C4D40"),
            code: "PY",
            name: "Paraguay",
            nameKey: "REFERENCE_DATA.COUNTRY.PARAGUAY"
        ),
        CountryModel(
            id: UUID(uuidString: "FBC07AA5-9ECF-405A-BD0F-7118D7DF6E69"),
            code: "QA",
            name: "Qatar",
            nameKey: "REFERENCE_DATA.COUNTRY.QATAR"
        ),
        CountryModel(
            id: UUID(uuidString: "2C3017DF-25A1-4AFD-8800-EFAB0E7E1A56"),
            code: "RE",
            name: "Réunion",
            nameKey: "REFERENCE_DATA.COUNTRY.REUNION"
        ),
        CountryModel(
            id: UUID(uuidString: "8F58B97C-B838-4001-903A-2A8C7DC5C952"),
            code: "RO",
            name: "Romania",
            nameKey: "REFERENCE_DATA.COUNTRY.ROMANIA"
        ),
        CountryModel(
            id: UUID(uuidString: "B7AE67B9-157F-419D-9AE7-AC93E0C9BBCE"),
            code: "RS",
            name: "Serbia",
            nameKey: "REFERENCE_DATA.COUNTRY.SERBIA"
        ),
        CountryModel(
            id: UUID(uuidString: "497F8817-E697-44BB-8B6E-2B76786138A7"),
            code: "RU",
            name: "Russia",
            nameKey: "REFERENCE_DATA.COUNTRY.RUSSIA"
        ),
        CountryModel(
            id: UUID(uuidString: "F32DD7B8-483F-444D-9E5A-0D9C509E4ABC"),
            code: "RW",
            name: "Rwanda",
            nameKey: "REFERENCE_DATA.COUNTRY.RWANDA"
        ),
        CountryModel(
            id: UUID(uuidString: "E17666C4-7C70-4922-872C-B1FA6D8B8951"),
            code: "SA",
            name: "Saudi Arabia",
            nameKey: "REFERENCE_DATA.COUNTRY.SAUDI_ARABIA"
        ),
        CountryModel(
            id: UUID(uuidString: "801443B9-5850-406D-A7AD-5DE36D9F492E"),
            code: "SB",
            name: "Solomon Islands",
            nameKey: "REFERENCE_DATA.COUNTRY.SOLOMON_ISLANDS"
        ),
        CountryModel(
            id: UUID(uuidString: "51339698-ED82-4F9A-90D6-3BB7410A4D69"),
            code: "SC",
            name: "Seychelles",
            nameKey: "REFERENCE_DATA.COUNTRY.SEYCHELLES"
        ),
        CountryModel(
            id: UUID(uuidString: "6E0C54BC-483C-4EC8-BE29-C621CCA055DB"),
            code: "SD",
            name: "Sudan",
            nameKey: "REFERENCE_DATA.COUNTRY.SUDAN"
        ),
        CountryModel(
            id: UUID(uuidString: "5C7256A4-9F2E-4072-BBB6-DC18E301BAD7"),
            code: "SE",
            name: "Sweden",
            nameKey: "REFERENCE_DATA.COUNTRY.SWEDEN"
        ),
        CountryModel(
            id: UUID(uuidString: "2E210270-F4A5-46EA-B9AD-3CC403F71B26"),
            code: "SG",
            name: "Singapore",
            nameKey: "REFERENCE_DATA.COUNTRY.SINGAPORE"
        ),
        CountryModel(
            id: UUID(uuidString: "E63735CC-39FA-4D93-9D83-04DAE3B8647E"),
            code: "SH",
            name: "St Helena",
            nameKey: "REFERENCE_DATA.COUNTRY.ST_HELENA"
        ),
        CountryModel(
            id: UUID(uuidString: "9DC51641-5463-4DA4-8369-C226711FD651"),
            code: "SI",
            name: "Slovenia",
            nameKey: "REFERENCE_DATA.COUNTRY.SLOVENIA"
        ),
        CountryModel(
            id: UUID(uuidString: "F99E8706-F3CE-480E-B675-12B72DCF2F6F"),
            code: "SJ",
            name: "Svalbard & Jan Mayen",
            nameKey: "REFERENCE_DATA.COUNTRY.SVALBARD_AND_JAN_MAYEN"
        ),
        CountryModel(
            id: UUID(uuidString: "5A3499FB-E7D0-4336-8398-6BE4A4F51C0C"),
            code: "SK",
            name: "Slovakia",
            nameKey: "REFERENCE_DATA.COUNTRY.SLOVAKIA"
        ),
        CountryModel(
            id: UUID(uuidString: "6DE49B91-8A1A-48E2-946F-F280CF195EFE"),
            code: "SL",
            name: "Sierra Leone",
            nameKey: "REFERENCE_DATA.COUNTRY.SIERRA_LEONE"
        ),
        CountryModel(
            id: UUID(uuidString: "FEEF6602-7DED-473F-8CC6-9901B378948F"),
            code: "SM",
            name: "San Marino",
            nameKey: "REFERENCE_DATA.COUNTRY.SAN_MARINO"
        ),
        CountryModel(
            id: UUID(uuidString: "5AE9618E-28AB-44E7-A0CE-AEE760266E29"),
            code: "SN",
            name: "Senegal",
            nameKey: "REFERENCE_DATA.COUNTRY.SENEGAL"
        ),
        CountryModel(
            id: UUID(uuidString: "9289698B-0BE8-484A-B683-0BE7A85B323E"),
            code: "SO",
            name: "Somalia",
            nameKey: "REFERENCE_DATA.COUNTRY.SOMALIA"
        ),
        CountryModel(
            id: UUID(uuidString: "EACBD072-9F7E-47DE-8750-B99C89697CAA"),
            code: "SR",
            name: "Suriname",
            nameKey: "REFERENCE_DATA.COUNTRY.SURINAME"
        ),
        CountryModel(
            id: UUID(uuidString: "3E416729-FA38-43E9-B01C-42E414A457EC"),
            code: "SS",
            name: "South Sudan",
            nameKey: "REFERENCE_DATA.COUNTRY.SOUTH_SUDAN"
        ),
        CountryModel(
            id: UUID(uuidString: "451FBCE9-55AC-4EF2-9D8C-7158BBD92D72"),
            code: "ST",
            name: "São Tomé & Príncipe",
            nameKey: "REFERENCE_DATA.COUNTRY.SAO_TOME_AND_PRINCIPE"
        ),
        CountryModel(
            id: UUID(uuidString: "02FEFE37-C1CE-4EB7-942D-8E1317D2D3DC"),
            code: "SV",
            name: "El Salvador",
            nameKey: "REFERENCE_DATA.COUNTRY.EL_SALVADOR"
        ),
        CountryModel(
            id: UUID(uuidString: "2E3D0D46-3F6E-4188-90ED-4229AA0A944D"),
            code: "SX",
            name: "Sint Maarten",
            nameKey: "REFERENCE_DATA.COUNTRY.SINT_MAARTEN"
        ),
        CountryModel(
            id: UUID(uuidString: "ACF76C85-0784-4BE4-B25C-EFF013EFC4A6"),
            code: "SY",
            name: "Syria",
            nameKey: "REFERENCE_DATA.COUNTRY.SYRIA"
        ),
        CountryModel(
            id: UUID(uuidString: "36B6A089-BC76-46D7-A25F-A2725F9A0F3C"),
            code: "SZ",
            name: "Eswatini",
            nameKey: "REFERENCE_DATA.COUNTRY.ESWATINI"
        ),
        CountryModel(
            id: UUID(uuidString: "F24F762E-1866-46AA-A0CB-D6F980134AA2"),
            code: "TA",
            name: "Tristan da Cunha",
            nameKey: "REFERENCE_DATA.COUNTRY.TRISTAN_DA_CUNHA"
        ),
        CountryModel(
            id: UUID(uuidString: "C73023E3-423D-4ABB-BA9E-061943240D84"),
            code: "TC",
            name: "Turks & Caicos Islands",
            nameKey: "REFERENCE_DATA.COUNTRY.TURKS_AND_CAICOS_ISLANDS"
        ),
        CountryModel(
            id: UUID(uuidString: "586DBAC4-9911-403E-B3B2-BA82D0008C2E"),
            code: "TD",
            name: "Chad",
            nameKey: "REFERENCE_DATA.COUNTRY.CHAD"
        ),
        CountryModel(
            id: UUID(uuidString: "7EA120F7-791B-4669-9B05-60C8F06D7682"),
            code: "TF",
            name: "French Southern Territories",
            nameKey: "REFERENCE_DATA.COUNTRY.FRENCH_SOUTHERN_TERRITORIES"
        ),
        CountryModel(
            id: UUID(uuidString: "1C21E46C-8B86-411E-9B4D-F92572307AD9"),
            code: "TG",
            name: "Togo",
            nameKey: "REFERENCE_DATA.COUNTRY.TOGO"
        ),
        CountryModel(
            id: UUID(uuidString: "00285620-6C36-4703-A209-7616D9BA8887"),
            code: "TH",
            name: "Thailand",
            nameKey: "REFERENCE_DATA.COUNTRY.THAILAND"
        ),
        CountryModel(
            id: UUID(uuidString: "DFFE61B3-BFBD-4D22-AC56-67CAF905EFAC"),
            code: "TJ",
            name: "Tajikistan",
            nameKey: "REFERENCE_DATA.COUNTRY.TAJIKISTAN"
        ),
        CountryModel(
            id: UUID(uuidString: "E4F5B9C8-FEE8-4253-855C-3F22AC1BEEC4"),
            code: "TK",
            name: "Tokelau",
            nameKey: "REFERENCE_DATA.COUNTRY.TOKELAU"
        ),
        CountryModel(
            id: UUID(uuidString: "FEE59132-F93E-43EA-8FDC-D436926C8692"),
            code: "TL",
            name: "Timor-Leste",
            nameKey: "REFERENCE_DATA.COUNTRY.TIMOR_LESTE"
        ),
        CountryModel(
            id: UUID(uuidString: "EFFD766D-8A2E-49C5-8EEF-3C1D6DE6F626"),
            code: "TM",
            name: "Turkmenistan",
            nameKey: "REFERENCE_DATA.COUNTRY.TURKMENISTAN"
        ),
        CountryModel(
            id: UUID(uuidString: "BBC7B9D0-853A-4F43-BB1A-001EDD8EE649"),
            code: "TN",
            name: "Tunisia",
            nameKey: "REFERENCE_DATA.COUNTRY.TUNISIA"
        ),
        CountryModel(
            id: UUID(uuidString: "892A350D-A7C2-49EE-BFED-90F4457E22A4"),
            code: "TO",
            name: "Tonga",
            nameKey: "REFERENCE_DATA.COUNTRY.TONGA"
        ),
        CountryModel(
            id: UUID(uuidString: "B2A9A2D4-2B01-4C49-9F10-4FE79541A960"),
            code: "TR",
            name: "Türkiye",
            nameKey: "REFERENCE_DATA.COUNTRY.TURKIYE"
        ),
        CountryModel(
            id: UUID(uuidString: "FE031902-EE68-4E98-B18A-D2A2F0870CBB"),
            code: "TT",
            name: "Trinidad & Tobago",
            nameKey: "REFERENCE_DATA.COUNTRY.TRINIDAD_AND_TOBAGO"
        ),
        CountryModel(
            id: UUID(uuidString: "4FC370AC-1871-478E-8C03-C50C8EEE7390"),
            code: "TV",
            name: "Tuvalu",
            nameKey: "REFERENCE_DATA.COUNTRY.TUVALU"
        ),
        CountryModel(
            id: UUID(uuidString: "C19C15F8-EAE0-4DB2-BBF6-8B3C8CE6AEDF"),
            code: "TW",
            name: "Taiwan",
            nameKey: "REFERENCE_DATA.COUNTRY.TAIWAN"
        ),
        CountryModel(
            id: UUID(uuidString: "CC478C28-0069-4968-8CD5-39564F8A5591"),
            code: "TZ",
            name: "Tanzania",
            nameKey: "REFERENCE_DATA.COUNTRY.TANZANIA"
        ),
        CountryModel(
            id: UUID(uuidString: "7B14A6FE-C2B5-48F0-8F51-F41E2F14E858"),
            code: "UA",
            name: "Ukraine",
            nameKey: "REFERENCE_DATA.COUNTRY.UKRAINE"
        ),
        CountryModel(
            id: UUID(uuidString: "D8414B66-347B-47E1-B02C-00DFAA6FF3B9"),
            code: "UG",
            name: "Uganda",
            nameKey: "REFERENCE_DATA.COUNTRY.UGANDA"
        ),
        CountryModel(
            id: UUID(uuidString: "04B2BD12-B4B5-4CE6-8A4F-854C29BC697E"),
            code: "UM",
            name: "US Outlying Islands",
            nameKey: "REFERENCE_DATA.COUNTRY.US_OUTLYING_ISLANDS"
        ),
        CountryModel(
            id: UUID(uuidString: "11C93175-5537-477C-B7D8-721EA92DF014"),
            code: "US",
            name: "United States",
            nameKey: "REFERENCE_DATA.COUNTRY.UNITED_STATES"
        ),
        CountryModel(
            id: UUID(uuidString: "A839C828-41DF-45F9-8AFF-68B59D9510C1"),
            code: "UY",
            name: "Uruguay",
            nameKey: "REFERENCE_DATA.COUNTRY.URUGUAY"
        ),
        CountryModel(
            id: UUID(uuidString: "B0A6EFA3-3D40-4B8B-BA69-C93547046853"),
            code: "UZ",
            name: "Uzbekistan",
            nameKey: "REFERENCE_DATA.COUNTRY.UZBEKISTAN"
        ),
        CountryModel(
            id: UUID(uuidString: "909851B6-039C-4031-B8BF-0E5BFE761C2D"),
            code: "VA",
            name: "Vatican City",
            nameKey: "REFERENCE_DATA.COUNTRY.VATICAN_CITY"
        ),
        CountryModel(
            id: UUID(uuidString: "8A498098-CCAF-457B-8025-FA88D5E9B556"),
            code: "VC",
            name: "St Vincent & the Grenadines",
            nameKey: "REFERENCE_DATA.COUNTRY.ST_VINCENT_AND_THE_GRENADINES"
        ),
        CountryModel(
            id: UUID(uuidString: "C6322D39-2FD1-4638-9F16-8182EE2F01EE"),
            code: "VE",
            name: "Venezuela",
            nameKey: "REFERENCE_DATA.COUNTRY.VENEZUELA"
        ),
        CountryModel(
            id: UUID(uuidString: "A52B9347-460D-48F8-AD7F-1EC856F8E679"),
            code: "VG",
            name: "British Virgin Islands",
            nameKey: "REFERENCE_DATA.COUNTRY.BRITISH_VIRGIN_ISLANDS"
        ),
        CountryModel(
            id: UUID(uuidString: "C0167CB1-6A4B-4BFF-AC43-4EFCB0E80107"),
            code: "VI",
            name: "US Virgin Islands",
            nameKey: "REFERENCE_DATA.COUNTRY.US_VIRGIN_ISLANDS"
        ),
        CountryModel(
            id: UUID(uuidString: "F2CC14E3-CA71-49EC-9647-5098D68C2A15"),
            code: "VN",
            name: "Vietnam",
            nameKey: "REFERENCE_DATA.COUNTRY.VIETNAM"
        ),
        CountryModel(
            id: UUID(uuidString: "DC982F84-D8CD-4BBA-B3F7-FBCA1FCCB855"),
            code: "VU",
            name: "Vanuatu",
            nameKey: "REFERENCE_DATA.COUNTRY.VANUATU"
        ),
        CountryModel(
            id: UUID(uuidString: "C6264426-4851-4A23-926F-7B82A30E0834"),
            code: "WF",
            name: "Wallis & Futuna",
            nameKey: "REFERENCE_DATA.COUNTRY.WALLIS_AND_FUTUNA"
        ),
        CountryModel(
            id: UUID(uuidString: "F3AEDFE0-FCE7-4DAC-89EF-721E4DC43689"),
            code: "WS",
            name: "Samoa",
            nameKey: "REFERENCE_DATA.COUNTRY.SAMOA"
        ),
        CountryModel(
            id: UUID(uuidString: "0FB97353-A489-4B8F-B207-2CE23CB879E7"),
            code: "XK",
            name: "Kosovo",
            nameKey: "REFERENCE_DATA.COUNTRY.KOSOVO"
        ),
        CountryModel(
            id: UUID(uuidString: "1408DC93-BD21-41C0-86AB-DE90DC7A7191"),
            code: "YE",
            name: "Yemen",
            nameKey: "REFERENCE_DATA.COUNTRY.YEMEN"
        ),
        CountryModel(
            id: UUID(uuidString: "0F20A96E-3FED-4BB0-8997-B29D0326E853"),
            code: "YT",
            name: "Mayotte",
            nameKey: "REFERENCE_DATA.COUNTRY.MAYOTTE"
        ),
        CountryModel(
            id: UUID(uuidString: "07545E35-5CF6-4B4F-89D9-60BBCF7A19BF"),
            code: "ZA",
            name: "South Africa",
            nameKey: "REFERENCE_DATA.COUNTRY.SOUTH_AFRICA"
        ),
        CountryModel(
            id: UUID(uuidString: "E3EFA999-B88A-4497-9EDD-87CC35501E15"),
            code: "ZM",
            name: "Zambia",
            nameKey: "REFERENCE_DATA.COUNTRY.ZAMBIA"
        ),
        CountryModel(
            id: UUID(uuidString: "83B66DD9-4AB3-4E66-B537-13F885319178"),
            code: "ZW",
            name: "Zimbabwe",
            nameKey: "REFERENCE_DATA.COUNTRY.ZIMBABWE"
        )
    ]

}
