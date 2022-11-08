import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { OfficesService } from './offices.service';
import { CreateOfficeDto } from './dto/create-office.dto';

import { Office as OfficeModel } from '@prisma/client';
import { UpdateOfficeDto } from './dto/update-office.dto';

@Controller('offices')
export class OfficesController {
  constructor(private readonly officesService: OfficesService) {}

  // CREAR SECRETARIA
  @Post()
  async create(@Body() createOfficeDto: CreateOfficeDto): Promise<OfficeModel> {
    return this.officesService.create(createOfficeDto);
  }

  // OBTENER TODAS LAS SECRETARÍAS
  @Get()
  findAll(): Promise<OfficeModel[]> {
    return this.officesService.findAll({});
  }

  // OBTENER SECRETARÍAS POR ID
  @Get(':id')
  findOne(@Param('id') id: string): Promise<OfficeModel> {
    return this.officesService.findOne({ id: Number(id) });
  }

  // OBTENER SECRETARÍAS POR ID DE JUZGADO
  @Get('filter-by-court/:id')
  findOneByCourt(@Param('id') id: string): Promise<OfficeModel[]> {
    return this.officesService.findOneByCourt(id);
  }

  // ACTIALIZAR SECRETARÍAS POR ID
  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateOfficeDto: UpdateOfficeDto,
  ): Promise<OfficeModel> {
    return this.officesService.remove({ id: Number(id) });
  }
}
