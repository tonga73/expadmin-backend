import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { CourtsService } from './courts.service';
import { CreateCourtDto } from './dto/create-court.dto';
import { UpdateCourtDto } from './dto/update-court.dto';

import { Court as CourtModel } from '@prisma/client';

@Controller('courts')
export class CourtsController {
  constructor(private readonly courtsService: CourtsService) {}

  // CREAR JUZGADO
  @Post()
  async create(@Body() createCourtDto: CreateCourtDto): Promise<CourtModel> {
    return this.courtsService.create(createCourtDto);
  }

  // OBTENER TODOS LOS JUZGADOS
  @Get()
  findAll(): Promise<CourtModel[]> {
    return this.courtsService.findAll({});
  }

  // OBTENER JUZGADO POR ID
  @Get(':id')
  findOne(@Param('id') id: string): Promise<CourtModel> {
    return this.courtsService.findOne({ id: Number(id) });
  }

  // EDITAR JUZGADO POR ID
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateCourtDto: UpdateCourtDto) {
    return this.courtsService.update(+id, updateCourtDto);
  }

  // ELIMINAR JUZGADO POR ID
  @Delete(':id')
  remove(@Param('id') id: string): Promise<CourtModel> {
    return this.courtsService.remove({ id: Number(id) });
  }
}
