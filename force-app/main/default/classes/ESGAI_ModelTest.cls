@IsTest
public class ESGAI_ModelTest {
    @isTest
    static void testParse() {
        String json=		'{'+
        '      "id": "text-davinci-001",'+
        '      "object": "model",'+
        '      "created": 1649364042,'+
        '      "owned_by": "openai",'+
        '      "permission": ['+
        '        {'+
        '          "id": "modelperm-MVM5NfoRjXkDve3uQW3YZDDt",'+
        '          "object": "model_permission",'+
        '          "created": 1669066355,'+
        '          "allow_create_engine": false,'+
        '          "allow_sampling": true,'+
        '          "allow_logprobs": true,'+
        '          "allow_search_indices": false,'+
        '          "allow_view": true,'+
        '          "allow_fine_tuning": false,'+
        '          "organization": "*",'+
        '          "group": null,'+
        '          "is_blocking": false'+
        '        }'+
        '      ],'+
        '      "root": "text-davinci-001",'+
        '      "parent": null'+
        '    }'+
        '';
        ESGAI_Model obj = ESGAI_Model.parse(json);
        System.assert(obj != null);
    }
}