"use strict";
var __createBinding = (this && this.__createBinding) || (Object.create ? (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    var desc = Object.getOwnPropertyDescriptor(m, k);
    if (!desc || ("get" in desc ? !m.__esModule : desc.writable || desc.configurable)) {
      desc = { enumerable: true, get: function() { return m[k]; } };
    }
    Object.defineProperty(o, k2, desc);
}) : (function(o, m, k, k2) {
    if (k2 === undefined) k2 = k;
    o[k2] = m[k];
}));
var __setModuleDefault = (this && this.__setModuleDefault) || (Object.create ? (function(o, v) {
    Object.defineProperty(o, "default", { enumerable: true, value: v });
}) : function(o, v) {
    o["default"] = v;
});
var __importStar = (this && this.__importStar) || function (mod) {
    if (mod && mod.__esModule) return mod;
    var result = {};
    if (mod != null) for (var k in mod) if (k !== "default" && Object.prototype.hasOwnProperty.call(mod, k)) __createBinding(result, mod, k);
    __setModuleDefault(result, mod);
    return result;
};
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const userServices = __importStar(require("../services/userServices"));
const user_controller_1 = require("../controllers/user_controller");
//import toNewUser from '../extras/utils'
const router = express_1.default.Router();
router.get('/', (_req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const data = yield userServices.getEntries.getAll();
    return res.json(data);
}));
router.get('/:id', (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const data = yield userServices.getEntries.findById(req.params.id);
    return res.json(data);
}));
router.post('/newUser', (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const data = yield userServices.getEntries.create(req.body);
    return res.json(data);
}));
router.post('/logIn', user_controller_1.logIn);
router.post('/addExperiencias/:idUser/:idExp', (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const data = yield userServices.getEntries.addExperiencies(req.params.idUser, req.params.idExp);
    return res.json(data);
}));
router.put('/:id', (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const data = yield userServices.getEntries.update(req.params.id, req.body);
    return res.json(data);
}));
router.delete('/:id', (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const data = yield userServices.getEntries.delete(req.params.id);
    return res.json(data);
}));
router.delete('/delParticipant/:idUser/:idExp', (req, res) => __awaiter(void 0, void 0, void 0, function* () {
    const data = yield userServices.getEntries.delExperiencies(req.params.idUser, req.params.idExp);
    return res.json(data);
}));
exports.default = router;
